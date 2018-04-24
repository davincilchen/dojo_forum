class DojosController < ApplicationController

  before_action :set_dojo, only:[:show, :edit, :update, :destroy]

  def index
    @dojos = Dojo.all
  end

  def new
    @dojo = Dojo.new
  end

  def create
    @dojo = current_user.dojos.build(dojo_params)
    if @dojo.save
      flash[:notice] = "Artical was successfully created"
      redirect_to dojos_path
    else
      flash.now[:alert] = "Artical was failed to create"
      render :new
    end
  end

  def show
    @comment = Comment.new
  end


  def edit

  end

  def update
   if @dojo.update(dojo_params)
      flash[:notice] = "Artical was successfully updated"
      redirect_to dojo_path(@dojo)
    else
      flash.now[:alert] = "Artical was failed to update"
      render :edit
    end
  end

  def destroy
    @dojo.destroy
    redirect_to dojos_path
    flash[:alert] = "Artical was deleted"
  end



  private

  def dojo_params
    params.require(:dojo).permit(:title,
                                :description,
                                :image
                                )
  end


  def set_dojo
    @dojo = Dojo.find(params[:id])
  end

end
