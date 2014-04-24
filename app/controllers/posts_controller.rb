class PostsController < ApplicationController

    before_action :set_post, only: [:show, :edit, :update, :destroy]
    before_action :confirm_logged_in, except: [:public]
    before_action :find_author

    layout :choose_layout

    # GET /posts
    # GET /posts.json
    def index
        @posts = Post.newest_first
    end

    # GET /posts/1
    # GET /posts/1.json
    def show
    end

    # GET /posts/new
    def new
        @post = Post.new
        @authors = AdminUser.sorted
    end

    # GET /posts/1/edit
    def edit
        @authors = AdminUser.sorted
    end

    # POST /posts
    # POST /posts.json
    def create
        @post = Post.new(post_params)

        respond_to do |format|
            if @post.save
                format.html { redirect_to @post, notice: 'Post was successfully created.' }
                format.json { render action: 'show', status: :created, location: @post }
            else
                format.html { render action: 'new' }
                format.json { render json: @post.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /posts/1
    # PATCH/PUT /posts/1.json
    def update
        respond_to do |format|
            if @post.update(post_params)
                format.html { redirect_to @post, notice: 'Post was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render action: 'edit' }
                format.json { render json: @post.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /posts/1
    # DELETE /posts/1.json
    def destroy
        @post.destroy
        respond_to do |format|
            format.html { redirect_to posts_url }
            format.json { head :no_content }
        end
    end

    def public
        @post = Posts.where(:permalink => params[:permalink], :published => true).first
        if @post.nil?
            raise ActiveRecord::RecordNotFound
        else
            # display the page content using public.html.erb
        end
    end

    def move_up
        @post.move_higher
        respond_to do |format|
            format.html { redirect_to posts_url }
            format.json { head :no_content }
        end
    end

    def move_down
        @post.move_lower
        respond_to do |format|
            format.html { redirect_to posts_url }
            format.json { head :no_content }
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
        @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
        params.require(:post).permit(:title, :intro, :body, :permalink, :position, :published, :author)
    end

    def find_author
      if params[:author]
        @author = AdminUser.find(params[:author])
      end
    end

    def choose_layout
        action_name == "public" ? "internal" : "admin"
    end
end
