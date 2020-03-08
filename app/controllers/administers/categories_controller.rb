class Administers::CategoriesController < ApplicationController
  def new
  end

  def index
  	@category = Category.new
  	@categories = Category.all
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to administers_categories_path
    else
      render :index
    end
  end

  def edit
  end

  def update
  end

  private
  def category_params
    params.require(:category).permit(:name, :status)
end
