class ArticlesController < ApplicationController

  before_filter :require_login,
    :only => [:new, :edit]

  def index
    flash.keep
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(article_params)
      redirect_to @article
      flash[:notice] = 'Your article has been edited!'
    else
      flash[:error] = 'Your edits did not save. Please try again.'
      redirect_to :edit
    end
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

  private

  def require_login
    unless current_user
      redirect_to articles_path
      flash[:error] = 'You must log in first.'
    end
  end

  def article_params
    params.require(:article).permit(:title, :content)
  end

end
