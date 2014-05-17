class FotosController < ApplicationController

  before_action :confirm_logged_in, except: [:todos, :detalhes]
  before_action :set_foto, only: [:show, :edit, :update, :destroy, :detalhes]

  layout 'admin'

  # GET /fotos
  # GET /fotos.json
  def index
    @fotos = Foto.recentes
  end

  # GET /fotos/1
  # GET /fotos/1.json
  def show
  end

  # GET /fotos/new
  def new
    @foto = Foto.new
    @agendas = Agenda.passadas.recentes
  end

  # GET /fotos/1/edit
  def edit
    @agendas = Agenda.recentes
  end

  # POST /fotos
  # POST /fotos.json
  def create
    @foto = Foto.new(foto_params)

    respond_to do |format|
      if @foto.save
        format.html { redirect_to @foto, notice: 'Foto was successfully created.' }
        format.json { render action: 'show', status: :created, location: @foto }
      else
        @agendas = Agenda.recentes
        format.html { render action: 'new' }
        format.json { render json: @foto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fotos/1
  # PATCH/PUT /fotos/1.json
  def update
    respond_to do |format|
      if @foto.update(foto_params)
        format.html { redirect_to @foto, notice: 'Foto was successfully updated.' }
        format.json { head :no_content }
      else
        @agendas = Agenda.passadas.recentes
        format.html { render action: 'edit' }
        format.json { render json: @foto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fotos/1
  # DELETE /fotos/1.json
  def destroy
    @foto.destroy
    respond_to do |format|
      format.html { redirect_to fotos_url }
      format.json { head :no_content }
    end
  end

  def todos
    @fotos = Foto.publicadas
    render layout: "internal"
  end

  def detalhes
    @foto = Foto.where(:id => params[:id], :published => true).first
    if @foto.nil?
      raise ActiveRecord::RecordNotFound
    else
      # display the page content using public.html.erb
      photosRequest = Flickr.sets.get_photos(@foto.flickr_album_id, {sizes:["Thumbnail", "Large 1024"]})
      @photos = []
      photosRequest.each do |p|

        photo = {}

        p.thumbnail!
        photo[:title] = p.title
        photo[:thumbnail_url] = p.source_url

        p.largest!
        photo[:large_url] = p.source_url

        @photos << photo
      end
    end

    render layout: "internal"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_foto
      @foto = Foto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def foto_params
      params.require(:foto).permit(:nome, :agenda_id, :descricao, :flickr_album_id, :album_id, :published)
    end

    def choose_layout
      action_name == "public" ? "internal" : "admin"
    end
end
