class ArticlesController < ApplicationController

  before_filter :require_login,
    :only => [:new, :create, :edit, :update]

  def index
    flash.keep
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
    @article.categories.build
  end

  def create
    @article = Article.create(article_params)
    if @article.save
      redirect_to articles_path
      flash[:notice] = 'Your article has been posted!'
    else
      flash[:error] = 'Your article failed to post!'
      redirect_to :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(article_params)
      flash[:success] = 'Your article has been edited!'
      redirect_to @article
    else
      flash[:error] = 'Your edits did not save. Please try again.'
      redirect_to article_path
    end
  end

  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      redirect_to articles_path, :flash => { :success => "Article deleted!" }
    else
      redirect_to @article, :flash => { :error => "Article failed to be deleted." }
    end
  end

  private

  def require_login
    unless current_user
      redirect_to articles_path
      flash[:error] = 'You must log in first.'
    end
  end

  def article_params
    params.require(:article).permit(:title, :content, category_ids: [])
  end

end
