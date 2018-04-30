class Api::V1::PostsController < ApiController
  before_action :authenticate_user!, except: :index
  before_action :set_post, only: [:show, :update, :destroy]

  def index
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @posts = @category.dojos.who_can_see_dojos(current_user).public_post
    else
      @posts = Dojo.who_can_see_dojos(current_user).public_post
    end
    render "api/v1/posts/index"
  end

  def show
   if @post
      if Dojo.who_can_see_dojos(current_user).public_post.include?(@post)
        @post.vieweds.create(user: current_user) unless @post.is_viewed?(current_user)
        @comments = @post.comments
        render "api/v1/posts/show"
      else
        render json: {
          errors: "You don't have permission to see"
        }
      end
    else
      render json: {
        message: "Can't find the post!",
        status: 400
      }
    end
  end

   def create
    @post = current_user.dojos.build(post_params)
    if @post.save
      render json: {
        message: "Artical was successfully created",
        result: @post
      }
    else
      render json: {
        errors: @post.errors
      }
    end
  end

  def update
    if @post.update(post_params)
      render json: {
        message: "Artical was successfully updated",
        result: @post
      }
    else
      render json: {
        errors: @post.errors
      }
    end
  end

  private

    def post_params
      params.permit(:title, :description, :post_status, :authority, :image, category_ids: [])
    end

    def set_post
      @post = Dojo.find_by(id: params[:id])
    end
end
