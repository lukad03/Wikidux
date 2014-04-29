class ArticlesController < ApplicationController

  before_filter :require_login,
    :only => [:new]

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

  def create
    @article = Article.create(article_params)
    if @article.save
      redirect_to '/articles'
    else
      render "new"
    end
  end

  private

  def require_login
    unless current_user
      redirect_to articles_path
      flash[:error] = 'You must log in to create an article.'
    end
  end

  def article_params
    params.require(:article).permit(:title, :content)
  end

end
