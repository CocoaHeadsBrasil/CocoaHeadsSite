class AdminUsersController < ApplicationController

  layout "admin"

  before_action :confirm_logged_in

  def index
    @admin_users = AdminUser.sorted
  end

  def new
    @admin_user = AdminUser.new
  end

  def create
    @admin_user = AdminUser.new(admin_user_params)
    if @admin_user.save
      flash[:notice] = "User #{@admin_user.name} created successfully"
      redirect_to(:action => "index")
    else
      render('new')
    end
  end

  def edit
    @admin_user = AdminUser.find(params[:id])
  end

  def update
    @admin_user = AdminUser.find(params[:id])

    if @admin_user.update_attributes(admin_user_params)
      flash[:notice] = "User updated successfully"
      redirect_to(:action => 'index')
    else
      render('edit')
    end
  end

  def delete
    @admin_user = AdminUser.find(params[:id])
  end

  def destroy
    @admin_user = AdminUser.find(params[:id])

    if @admin_user.id == session[:user_id]
      flash[:error] = "You can not delete yourself. That's suicide."
      redirect_to(:action => 'index')
    else
      @admin_user.destroy
      flash[:notice] = "User #{@admin_user.name} deleted"
      redirect_to(:action => 'index')
    end
  end

  def upload_avatar
    @admin_user = AdminUser.find(params[:id])
    @uploader = AdminUser.new.avatar
    @uploader.success_action_redirect = persist_avatar_admin_user_url(@admin_user.id)
  end

  def persist_avatar
    @admin_user = AdminUser.find(params[:id])
    @admin_user.image_processed = false
    @admin_user.update_attribute :key, params[:key]

    if !params[:key].blank?
      flash[:notice] = "Avatar saved for #{@admin_user.name}"
      redirect_to(:action => 'index')
    else
      flash[:error] = "Error uploading avatar for #{@admin_user.name}"
      redirect_to(:action => 'upload_avatar', :id => @admin_user.id)
    end

  end

  private

    # Strong parameters
    def admin_user_params
      # same as using "params[:admin_user]", except that it:
      # - raises an error if :admin_user is not present
      # - allows listed attributes to be mass-assigned
      params.require(:admin_user).permit(:first_name, :last_name, :email, :username, :password, :password_confirmation, :avatar, :remote_avatar_url, :remove_avatar, :key)
    end
end
