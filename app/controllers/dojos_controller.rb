class DojosController < ApplicationController
  def index
  end

  def new
    @dojo = Dojo.new
  end

  def create
    @dojo = Dojo.new(dojo_params)
    if @dojo.save
      flash[:notice] = "Artical was successfully created"
      redirect_to dojos_path
    else
      flash.now[:alert] = "Artical was failed to create"
      render :new
    end
  end

  def show
  end


  def edit

  end

  def update

  end

  def destroy

  end



  private

  def dojo_params
    params.require(:dojo).permit(:title,
                                :description,
                                :image
                                )
  end

end
