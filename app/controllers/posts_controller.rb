class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
  end

  # GET /posts/new
  def new
    @post = current_user.posts.build
  end

  # GET /posts/1/edit
  def edit
    @post = current_user.posts.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.build(post_params)
 
    if @post.save
      redirect_to @post, notice: "Successfully saved"
    else
      render 'new'
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @post = current_user.posts.find(params[:id])

    if @post.update(post_params)
      redirect_to @post, notice: "Post was successfully updated"
    else
      render 'edit'
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
 
    redirect_to posts_path
  end

  private


    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:title, :text)
  end
end
