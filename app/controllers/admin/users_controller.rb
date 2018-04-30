class Admin::UsersController < Admin::BaseController
    def index
    @users = User.all
  end

  def update
    @user = User.find(params[:id])
    @user.update(role: params[:role])
    flash[:notice] = "Upddate role of #{@user.name} to #{params[:role]}"
    redirect_to admin_users_path
  end

end
