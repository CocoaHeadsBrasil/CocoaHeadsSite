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

  private

    # Strong parameters
    def admin_user_params
      # same as using "params[:admin_user]", except that it:
      # - raises an error if :admin_user is not present
      # - allows listed attributes to be mass-assigned
      params.require(:admin_user).permit(:first_name, :last_name, :email, :username, :password, :password_confirmation, :key)
    end
end
