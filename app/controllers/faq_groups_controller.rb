class FaqGroupsController < ApplicationController

  before_action :confirm_logged_in, except: [:public]
  before_action :set_faq_group, only: [:show, :create, :edit, :update, :destroy, :move_up, :move_down]

  layout :choose_layout

  def public
    @faq_groups = FaqGroup.published.sorted
    @user_opinions = read_faq_opinions_from_cookies
  end

  # GET /faq_groups
  # GET /faq_groups.json
  def index
    @faq_groups = FaqGroup.sorted
  end

  # GET /faq_groups/1
  # GET /faq_groups/1.json
  def show
  end

  # GET /faq_groups/new
  def new
    @faq_group = FaqGroup.new
    @groups_count = FaqGroup.count + 1
  end

  # GET /faq_groups/1/edit
  def edit
    @groups_count = FaqGroup.count + 1
  end

  # POST /faq_groups
  # POST /faq_groups.json
  def create
    @faq_group = FaqGroup.new(faq_group_params)

    respond_to do |format|
      if @faq_group.save
        format.html { redirect_to faq_groups_url, notice: 'FAQ group was successfully created.' }
        format.json { render action: 'show', status: :created, location: @faq_group }
      else
        format.html { render action: 'new' }
        format.json { render json: @faq_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /faq_groups/1
  # PATCH/PUT /faq_groups/1.json
  def update
    respond_to do |format|
      if @faq_group.update(faq_group_params)
        format.html { redirect_to faq_groups_url, notice: 'Faq group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @faq_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /faq_groups/1
  # DELETE /faq_groups/1.json
  def destroy
    @faq_group.destroy
    respond_to do |format|
      format.html { redirect_to faq_groups_url }
      format.json { head :no_content }
    end
  end

  def move_up
    @faq_group.move_higher
    respond_to do |format|
      format.html { redirect_to faq_groups_url }
      format.json { head :no_content }
    end
  end

  def move_down
    @faq_group.move_lower
    respond_to do |format|
      format.html { redirect_to faq_groups_url }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_faq_group
      if params[:id].present?
        @faq_group = FaqGroup.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def faq_group_params
      params.require(:faq_group).permit(:title, :position, :published)
    end

    def choose_layout
      action_name == "public" ? "internal" : "admin"
    end
end
