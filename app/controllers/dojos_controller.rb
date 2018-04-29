class DojosController < ApplicationController

  before_action :set_dojo, only:[:show, :edit, :update, :destroy, :collect, :uncollect]

  def index
    @categories = Category.all
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @ransack = @category.dojos.who_can_see_dojos(current_user).public_post.ransack(params[:q])
    else
      @ransack = Dojo.who_can_see_dojos(current_user).public_post.ransack(params[:q])
    end
    @dojos = @ransack.result(distinct: true).page(params[:page]).per(20)
  end

  def new
    @dojo = Dojo.new
  end

  def create
    @dojo = current_user.dojos.build(dojo_params)
    if params[:commit] == "Save Draft"
      @dojo.post_status = "draft"
    else
      @dojo.post_status = "public"
    end

    if @dojo.save
      flash[:notice] = "Artical was successfully created"
      redirect_to dojos_path
    else
      flash.now[:alert] = "Artical was failed to create"
      render :new
    end
  end

  def show
    @dojo.viewed_dojo;
    @dojo.vieweds.create(user: current_user) unless @dojo.is_viewed?(current_user)
    @comment = Comment.new
    @comments = @dojo.comments.includes(:user).page(params[:page]).per(20)
    @edit_type = params[:edit_type]
    @edit_id = params[:edit_id]
  end


  def edit

  end

  def update
    if params[:commit] == "Save Draft"
      @dojo.post_status = "draft"
    else
      @dojo.post_status = "public"
    end

    if @dojo.update(dojo_params)
      flash[:notice] = "Artical was successfully updated (#{@dojo.post_status} mode)"
      redirect_to dojo_path(@dojo)
    else
      flash.now[:alert] = "Artical was failed to update"
      render :edit
    end
  end

  def destroy
    @dojo.destroy
    redirect_to user_path(current_user)
    flash[:alert] = "Artical was deleted"
  end

  # POST /dojos/:id/collect
  def collect
    @dojo.collects.create!(user: current_user)
    #@dojo.collects.create!(user_id: current_user.id)
    #Favorite.create(dojo: @dojo, user: current_user)
    #current_user.collects.create(dojo: @dojo)
  end


  # POST /dojos/:id/uncollect
  def uncollect
    @from_page = params[:page]
    collects = Collect.where(dojo: @dojo, user: current_user)
    collects.destroy_all
  end


  private

  def dojo_params
    params.require(:dojo).permit(:title,
                                :description,
                                :post_status,
                                :authority,
                                :image,
                                :category_ids => []
                                )
  end


  def set_dojo
    @dojo = Dojo.find(params[:id])
  end

end
