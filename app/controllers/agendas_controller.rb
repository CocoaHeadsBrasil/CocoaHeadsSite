class AgendasController < ApplicationController

  before_action :confirm_logged_in, except: [:ativas, :export, :maps, :detalhes]
  before_action :set_agenda, only: [:show, :edit, :update, :destroy, :export, :maps, :detalhes]

  layout 'admin'

  # GET /agendas
  # GET /agendas.json
  def index
    @agendas = Agenda.all
  end

  # GET /agendas/1
  # GET /agendas/1.json
  def show
  end

  # GET /agendas/new
  def new
    @agenda = Agenda.new
    @cidades = Cidade.order('cidade ASC')
  end

  # GET /agendas/1/edit
  def edit
    @cidades = Cidade.order('cidade ASC')
  end

  # POST /agendas
  # POST /agendas.json
  def create
    @agenda = Agenda.new(agenda_params)
    respond_to do |format|
      if @agenda.save
        format.html { redirect_to @agenda, notice: 'Agenda was successfully created.' }
        format.json { render action: 'show', status: :created, location: @agenda }
      else
        @cidades = Cidade.order('cidade ASC')
        format.html { render action: 'new' }
        format.json { render json: @agenda.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /agendas/1
  # PATCH/PUT /agendas/1.json
  def update
    respond_to do |format|
      if @agenda.update(agenda_params)
        format.html { redirect_to @agenda, notice: 'Agenda was successfully updated.' }
        format.json { head :no_content }
      else
        @cidades = Cidade.order('cidade ASC')
        format.html { render action: 'edit' }
        format.json { render json: @agenda.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /agendas/1
  # DELETE /agendas/1.json
  def destroy
    @agenda.destroy
    respond_to do |format|
      format.html { redirect_to agendas_url }
      format.json { head :no_content }
    end
  end

  # GET /agendas/1
  # GET /agendas/1.json
  # GET /agendas/1.ics
  def export
    respond_to do |format|
      format.html
      format.json { render json: @agenda }
      format.ics do
        calendar = Icalendar::Calendar.new
        calendar.add_event(@agenda.to_ics)
        calendar.publish
        response.headers['Content-Disposition'] = 'attachment; filename="' + @agenda.descritivo.parameterize + '.ics"'
        render :text => calendar.to_ical
      end
    end
  end

  def maps
    render layout: "internal_clean"
  end

  def ativas
    @agendas = Agenda.ativas.publicadas.recentes
    render layout: "internal_fullscreen"
  end

  def todas
    @agendas = Agenda.recentes.paginate(:page => params[:page])
    render layout: "internal_fullscreen"
  end

  def detalhes
    render layout: "internal"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_agenda
      @agenda = Agenda.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def agenda_params
      params.require(:agenda).permit(:data, :nome, :cidade_id, :endereco, :latitude, :longitude, :local, :maps, :passbook, :flickr_album, :published, :descricao)
    end
end
