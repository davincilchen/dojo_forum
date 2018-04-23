class UsersController < ApplicationController
  before_action :set_user, only:[:show]

  def show

  end 

  private

  def user_params
     params.require(:user).permit(:name, :introduction ,:avatar)
  end

  def set_user
    puts "1--0-0-qeaq"
    @user = User.find(params[:id])
  end

end
