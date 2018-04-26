class Admin::CategoriesController < ApplicationController
  def index
    @categories = Category.all
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if ! Category.where('lower(name) = ?', @category.name.downcase).first
      if @category.save
        redirect_to admin_categories_path, notice: "Category was successfully created"
      else
        @categories = Category.all
        render :index
      end
    else
      flash[:alert] = "Category was already exist"
      @categories = Category.all
      render :index
    end
  end

 private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end

end
