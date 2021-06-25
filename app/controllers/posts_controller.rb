class PostsController < ApplicationController

  before_action :set_post, only: [:show, :edit, :update, :destroy]


  def index
    @posts = Post.all
  end

  def show
    @favorite = current_user.favorites.find_by(post_id: @post.id)
  end

  def edit
    if @post.user != current_user
      flash.now[:error] = 'unauthorized access!'
      redirect_to posts_path
    else
    end

  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if params[:back]
      render :new
    else
      if @post.save
         PostMailer.post_mail(@post).deliver
        redirect_to posts_path, notice: "i post a blog！"
      else
        render :new
      end
    end
  end


  def update

    if @post.update(post_params)
      redirect_to posts_path, notice: "I edited the blog!"
    else
      render :edit
    end
  end

  def set_post
      @post = Post.find(params[:id])
  end


  def destroy

    if @post.user != current_user
      flash.now[:error] = 'unauthorized access!'
      redirect_to posts_path
    else

    @post.destroy
    redirect_to posts_path, notice:"I deleted the blog!"
  end
end



  def confirm
      @post = current_user.posts.build(post_params)
      #@post = Post.new(post_params)
      render :new if @post.invalid?
  end



  private
  def set_post
   @post = Post.find(params[:id])
 end
 def post_params
   params.require(:post).permit(:content,:avatar)
 end


  private
  def post_params
     params.require(:post).permit(:content,:avatar, :avatar_cache)
  end


end
