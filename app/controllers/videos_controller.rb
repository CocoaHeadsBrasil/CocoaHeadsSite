class VideosController < ApplicationController

  before_action :confirm_logged_in, except: [:todos, :detalhes, :itunes, :itunes_redirect]
  before_action :set_video, only: [:show, :edit, :update, :destroy, :detalhes, :itunes_redirect]
  before_action :find_palestrante, :except => [:useful]

  layout 'admin'

  # GET /videos
  # GET /videos.json
  def index
    @videos = @palestrante.videos.mais_novos
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
  end

  # GET /videos/new
  def new
    @video = Video.new({:palestrante_id => @palestrante.id})
    @palestrantes = Palestrante.ordenados
    @agendas = Agenda.recentes
  end

  # GET /videos/1/edit
  def edit
    @video = Video.find(params[:id])
    @palestrantes = Palestrante.ordenados
    @agendas = Agenda.recentes
  end

  # POST /videos
  # POST /videos.json
  def create
    @video = Video.new(video_params)

    respond_to do |format|

      if @video.save
        format.html {
          flash[:notice] = "Vídeo criado!."
          redirect_to(:action => 'show', :id => @video.id, :palestrante_id => @palestrante.id)
        }
        format.json { 
          render action: 'show', :palestrante_id => @palestrante.id, status: :created, location: @video
        }
      else
        format.html {
          @palestrantes = Palestrante.ordenados
          @agendas = Agenda.recentes
          render action: 'new'
        }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { 
          flash[:notice] = "Vídeo atualizado!"
          redirect_to(:action => 'show', :id => @video.id, :palestrante_id => @palestrante.id)
        }
        format.json { head :no_content }
      else
        format.html { 
          @agendas = Agenda.recentes
          @palestrantes = Palestrante.order('nome ASC')
          render action: 'edit' 
        }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to ({:action => "index", :palestrante_id => @palestrante.id}) }
      format.json { head :no_content }
    end
  end

  def todos
    @videos = Video.mais_novos.publicados.paginate(:page => params[:page])

    respond_to do |format|
      format.html { render layout: "internal" }
      format.json { render json: @videos }
    end
  end

  def detalhes
    render layout: "internal"
  end

  # GET /videos
  # GET /videos.rss
  def itunes
    @videos = Video.mais_novos.publicados.com_podcast
  end

  def itunes_redirect
    if @video.podcast?
      @video.increment!(:podcast_counter)
      redirect_to @video.podcast_stream_url, status: :found
    else
      redirect_to action: 'todos'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:titulo, :palestrante_id, :agenda_id, :descricao, :source, :youtube, :published, :tags, :podcast_stream_url, :podcast_duration)
    end

    def find_palestrante
      if params[:palestrante_id]
        @palestrante = Palestrante.find(params[:palestrante_id])
      end
    end
end
