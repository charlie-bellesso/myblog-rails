class PostsController < ApplicationController

  # only Logged users can create or edit a post
  before_filter :authorize, only: [:new, :create, :edit, :update]

  # only posts owners can edit their posts
  before_filter :is_post_owner, only: [:edit, :update, :destroy]

  # find a post by id and put it in @post
  before_filter :find_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all.order 'created_at DESC'
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params.merge(:user_id => current_user.id))
    if @post.save
      flash_msg 'Your post was successfully created', 'success'
      redirect_to controller: 'posts', action: 'show', id: @post.id
    else
      flash_msg 'upps.. something went wrong', 'error'
      render 'posts/new'
    end
  end

  def update
    if @post.update(post_params)
      flash_msg 'Your post was successfully updated', 'success'
      redirect_to controller: 'posts', action: 'show', id: @post.id
    else
      flash_msg 'upps.. something went wrong', 'error'
      render 'posts/edit'
    end
  end

  def edit
  end

  def show
    @comment = Comment.new
    commentable = @post
    @comments = commentable.comments.recent.limit(10).all
  end

  def destroy
    @post.destroy
    flash_msg 'Your post was successfully deleted', 'success'
    redirect_to '/posts'
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def is_post_owner
    @post = Post.find(params[:id])
    redirect_to '/posts' unless @post.user.id == current_user.id
  end



end
