
class PodcastsController < ApplicationController
  before_action :confirm_logged_in, except: [:public_index, :public_show]
  before_action :set_podcast, only: [:show, :edit, :update, :destroy]

  layout 'admin'
  
  # GET /podcasts
  # GET /podcasts.json
  def public_index
    @cocoaheads_itunes = Cocoaheads::Application::COCOAHEADS_SOCIAL_ITUNES
    @podcasts = Podcast.all.order(soundcloud_id: :desc)

    respond_to do |format|
      format.html { render layout: "internal" }
      format.json { render json: @podcasts }
    end
  end

  # GET /podcasts/1
  # GET /podcasts/1.json
  def public_show
    @cocoaheads_itunes = Cocoaheads::Application::COCOAHEADS_SOCIAL_ITUNES
    @podcast = Podcast.find(params[:id])
    @podcast_description = @podcast.description.html_safe.gsub("\n", "<br/>").gsub( %r{(http|https)://[^\s<]+} ) do |url|
          "<a href='#{url}' target='_blank'>#{url}</a>"
      end
    respond_to do |format|
      format.html { render layout: "internal" }
      format.json { render json: @podcast }
    end
    
  rescue ActiveRecord::RecordNotFound
    redirect_to action: :public_index
  end
  
  def index
    @podcasts = Podcast.all.order(soundcloud_id: :desc)
  end

  # GET /podcasts/new
  def new
    redirect_to action: :index
  end

  # GET /podcasts/1/edit
  def show
  end
  
  # GET /podcasts/1/edit
  def edit
  end

  # POST /podcasts
  # POST /podcasts.json
  def create
    @podcast = Podcast.new(podcast_params)

    respond_to do |format|
      if @podcast.save
        format.html { redirect_to @podcast, notice: 'Podcast was successfully created.' }
        format.json { render action: 'show', status: :created, location: @podcast }
      else
        format.html { render action: 'new' }
        format.json { render json: @podcast.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /podcasts/1
  # PATCH/PUT /podcasts/1.json
  def update
    respond_to do |format|
      if @podcast.update(podcast_params)
        format.html { redirect_to @podcast, notice: 'Podcast was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @podcast.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /podcasts/1
  # DELETE /podcasts/1.json
  def destroy
    @podcast.destroy
    respond_to do |format|
      format.html { redirect_to podcasts_url }
      format.json { head :no_content }
    end
  end
  
  
  def todos
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_podcast
      @podcast = Podcast.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def podcast_params
      params.require(:podcast).permit(:title, :tags, :soundcloud_url, :itunes_url, :description, :created_at)
    end
    
end
