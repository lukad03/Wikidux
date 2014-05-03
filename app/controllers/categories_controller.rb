class CategoriesController < ApplicationController
  def index
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
  end

  def create
  end

  def edit
  end

  def destroy
  end
end
