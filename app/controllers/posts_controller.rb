class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.order(created_at: :desc)
  end

  def search
    @posts = Post.search(search_params[:q])
  end

  def show
    @comments = @post.comments.order(created_at: :desc)
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end
  
  def edit
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path, notice: "O post foi criado com sucesso !!!"
    else
      flash.now[:alert] = @post.errors.full_messages.to_sentence
      render :new, notice: "Não foi possivel criar um novo post" 
    end
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: "O post foi atualizado com sucesso !!!"
    else
     
      render :new, notice: "Não foi possivel editar um post" 
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path,  notice: "O post foi removido com sucesso !!!"
  end

  private

  def set_post
    @post = Post.friendly.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :author, :body)
  end

  def search_params
    params.permit(:q)
  end


end
