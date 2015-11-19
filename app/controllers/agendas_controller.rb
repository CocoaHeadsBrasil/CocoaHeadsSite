require 'ruby_meetup'

class AgendasController < ApplicationController

  before_action :confirm_logged_in, except: [:ativas, :export, :maps, :detalhes, :todas, :rsvps]
  before_action :set_agenda, only: [:show, :edit, :update, :destroy, :export, :maps, :detalhes]

  layout 'admin'

  # GET /agendas
  # GET /agendas.json
  def index
    @agendas = Agenda.recentes
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
      format.html { redirect_to({:action => :index}) }
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
    respond_to do |format|
      format.html { render layout: "internal_fullscreen" }
      format.json { render json: @agendas }
    end
  end

  def todas
    respond_to do |format|
      format.html { 
        @agendas = Agenda.recentes.paginate(:page => params[:page])
        render layout: "internal_fullscreen" 
      }
      format.json { 
        @agendas = Agenda.recentes
        render json: @agendas 
      }
    end
  end

  def detalhes
    render layout: "internal"
  end

  def rsvps
    agendas = Agenda.ativas.publicadas.recentes

    results = []

    # interage em cada agenda e formata o objeto de saida
    agendas.each do |agenda|
      dados_agenda = monta_hash_rsvp agenda
      results << dados_agenda
    end

    respond_to do |format|
      format.html { redirect_to agendas_url }
      format.json { render json: results }
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_agenda
      @agenda = Agenda.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def agenda_params
      params.require(:agenda).permit(:data, :nome, :cidade_id, :endereco, :latitude, :longitude, :local, :maps, :passbook, :meetup, :flickr_album, :published, :descricao)
    end

    # monta uma hash contendo a formatacao de rsvps do meetup.
    # caso o evento nao tenha meetup, retorna apenas os dados basicos
    def monta_hash_rsvp(agenda)

      RubyMeetup::ApiKeyClient.key = ENV['MEETUP_APIKEY']
      client = RubyMeetup::ApiKeyClient.new

      dados_agenda = {:nome => agenda.nome}
      dados_agenda[:data] = agenda.data
      dados_agenda[:cidade] = agenda.cidade.cidade

      # consulta rsvps
      unless agenda.meetup_event_id.nil?
        request = client.get_path("/2/event/" + agenda.meetup_event_id, {:only => "yes_rsvp_count,waitlist_count,maybe_rsvp_count,rsvp_limit"})
        rsvps = JSON.parse(request)

        dados_agenda[:rsvp_sim] = rsvps["yes_rsvp_count"].to_s.to_i
        dados_agenda[:rsvp_espera] = rsvps["waitlist_count"].to_s.to_i
        dados_agenda[:rsvp_talvez] = rsvps["maybe_rsvp_count"].to_s.to_i
        dados_agenda[:rsvp_limite] = rsvps["rsvp_limit"].to_s.to_i

        if dados_agenda[:rsvp_limite]
          dados_agenda[:rsvp_restante] = dados_agenda[:rsvp_limite].to_i - dados_agenda[:rsvp_sim].to_i
        end
      end

      dados_agenda
    end
end
