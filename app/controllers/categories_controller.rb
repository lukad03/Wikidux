class CategoriesController < ApplicationController

  before_filter :require_login,
    :only => [:new, :create, :edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.create(category_params)
    if @category.save
      redirect_to categories_path
      flash[:notice] = 'Your new category has been created!'
    else
      flash[:error] = 'Your category failed to be created!'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      redirect_to categories_path
      flash[:notice] = 'Your new category has been created!'
    else
      flash[:error] = 'Your category failed to be created!'
      redirect_to :new
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      redirect_to categories_path, :flash => { :success => "Category deleted!" }
    else
      redirect_to @category, :flash => { :error => "Category failed to delete." }
    end
  end

  private

  def require_login
    unless current_user
      redirect_to categories_path
      flash[:error] = 'You must log in first.'
    end
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
