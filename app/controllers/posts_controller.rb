class PostsController < ApplicationController
  respond_to :html

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = current_user.posts.build
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def create
    @post = current_user.posts.build(params[:post])

    if @post.save
      redirect_to @post, :notice => "Post was successfully created"
    else
      render :new
    end
  end

  def update
    @post = current_user.posts.find(params[:id])

    if @post.update_attributes(params[:post])
      redirect_to user_post_path(current_user, @post), :notice => "Post saved successfully"
    else
      render :new
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy

    redirect_to posts_url
  end
end
