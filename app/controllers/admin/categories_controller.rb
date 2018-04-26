class Admin::CategoriesController < ApplicationController
  before_action :set_category, only: [:update, :destroy]

  def index
    @categories = Category.all
    if params[:id]
      set_category
    else
      @category = Category.new
    end
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

  def update
    if ! Category.where('lower(name) = ?', params[:category][:name].downcase).first
      if @category.update(category_params)
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


  def destroy
    @category.destroy

    if @category.errors.any?
      flash[:alert] = @category.errors.full_messages.to_sentence
    else
      flash[:notice] = "Category was successfully deleted"
    end

    redirect_to admin_categories_path
  end


 private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end

end
