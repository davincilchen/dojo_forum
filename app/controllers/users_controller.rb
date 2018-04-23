class UsersController < ApplicationController
  before_action :set_user, only:[:show, :edit, :update]

  def show
    @tab = params[:tab]
    if @tab == "my_post" || !@tab
      @dojos = current_user.dojos
    end
  end 

  def edit
    if @user != current_user
      redirect_to user_path(@user)
    end
  end

  def update
    if @user == current_user
      if @user.update(user_params)
        flash[:notice] = "User was successfully update"
        redirect_to edit_user_path
      else
        flash.now[:alert] = "User was failed to update"
        render :edit
      end
    else
      redirect_to user_path(@user)
    end
  end

  private

  def user_params
     params.require(:user).permit(:name, :introduction ,:avatar)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
