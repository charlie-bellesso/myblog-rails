class CommentsController < ApplicationController

  # only Logged users can create or edit a post
  before_filter :authorize, only: [:create]

  # using the act_as_commentable gem
  def create
    @post  = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.recent.limit(10).all
    createdComment =  @post .comments.create(:user_id => current_user.id,
                                :comment => params[:comment][:comment])

    unless(createdComment[:id].nil?)
      flash_msg 'your comment has been successfully created', 'success'
    else
      flash_msg 'your comment can\'t be empty. Also is required a minimum length of 10 chars', 'error'
    end
    flash.keep
    redirect_to '/posts/'+params[:id]
  end
end
