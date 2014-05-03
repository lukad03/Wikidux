class CategoriesController < ApplicationController

  before_filter :require_login,
    :only => [:new, :edit]

  def index
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
  end

  def edit
  end

  def destroy
  end

  private

  def require_login
    unless current_user
      redirect_to categories_path
      flash[:error] = 'You must log in to create and edit categories.'
    end
  end

  def category_params
    params.require(:category).permit(:title, :content)
  end
end
