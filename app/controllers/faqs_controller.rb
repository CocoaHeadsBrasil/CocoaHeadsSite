class FaqsController < ApplicationController

  before_action :confirm_logged_in, :except => [:useful]
  before_action :find_group, :except => [:useful]

  layout :choose_layout

  # GET /faqs
  def useful
    is_usefull = params[:state] == 'true' ? true : false
    useful_flag = is_usefull ? "useful" : "unuseful"
    @faq = Faq.find(params[:id])

    # add reference on the cookies
    write_faq_opinions_in_cookies @faq.id

    if is_usefull
      @faq.markAsUseful
    else 
      @faq.markAsUnuseful
    end

    respond_to do |format|
      if @faq.save
        format.html { redirect_to :controller => 'faq_groups', :action => 'public', notice: "The question was flagged as #{useful_flag}." }
        format.json { render json: {:failure => false, :message => "Your opinion about this question was sent. Thank you."} }
      else
        format.html { render action: 'new' }
        format.json { render json: @faq.errors, status: :unprocessable_entity }
        format.json { render json: {:failure => true, :message => "Something went wrong. Please try again."} }
      end
    end
  end

  # GET /faqs
  # GET /faqs.json
  def index
    @faqs = @group.faqs.sorted
  end

  # GET /faqs/1
  # GET /faqs/1.json
  def show
    @faq = Faq.find(params[:id])
  end

  # GET /faqs/new
  def new
    @groups = FaqGroup.order('position ASC')
    @faq_count = @group.faqs.count + 1
    @faq = Faq.new({:faq_group_id => @group.id, :position => @faq_count})
  end

  # POST /faqs
  # POST /faqs.json
  def create
    @faq = Faq.new(faq_params)

    respond_to do |format|
      if @faq.save
        format.html {
          flash[:notice] = "FAQ was successfully created."
          redirect_to(:action => 'show', :id => @faq.id, :faq_group_id => @group.id)
        }
        format.json { 
          render action: 'show', :faq_group_id => @group.id, status: :created, location: @faq
        }
      else
        format.html {
          @groups = FaqGroup.order('position ASC')
          @faq_count = Faq.count + 1
          render action: 'new'
        }
        format.json { render json: @faq.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /faqs/1/edit
  def edit
    @faq = Faq.find(params[:id])
    @groups = FaqGroup.order('position ASC')
    @faq_count = Faq.count + 1
  end

  # PATCH/PUT /faqs/1
  # PATCH/PUT /faqs/1.json
  def update

    @faq = Faq.find(params[:id])

    respond_to do |format|
      if @faq.update(faq_params)
        format.html { 
          flash[:notice] = "FAQ was successfully updated."
          redirect_to(:action => 'show', :id => @faq.id, :faq_group_id => @group.id)
        }
        format.json { head :no_content }
      else
        format.html { 
          @groups = FaqGroup.order('position ASC')
          @faq_count = Faq.count + 1
          render action: 'edit' 
        }
        format.json { render json: @faq.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /faqs/1
  # DELETE /faqs/1.json
  def destroy
    @faq = Faq.find(params[:id]).destroy
    respond_to do |format|
      format.html { 
        flash[:notice] = "FAQ #{@faq.id} destroyed"
        redirect_to(:action => 'index', :faq_group_id => @group.id)
      }
      format.json { head :no_content }
    end
  end

  def move_up
    @faq = Faq.find(params[:id])
    @faq.move_higher
    respond_to do |format|
      format.html { redirect_to(:action => 'index', :faq_group_id => @group.id) }
      format.json { head :no_content }
    end
  end

  def move_down
    @faq = Faq.find(params[:id])
    @faq.move_lower
    respond_to do |format|
      format.html { redirect_to(:action => 'index', :faq_group_id => @group.id) }
      format.json { head :no_content }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def faq_params
      params.require(:faq).permit(:position, :published, :question, :answer, :faq_group_id)
    end

    def choose_layout
      action_name == "public" ? "internal" : "admin"
    end

    def find_group
      if params[:faq_group_id]
        @group = FaqGroup.find(params[:faq_group_id])
      end
    end
end
