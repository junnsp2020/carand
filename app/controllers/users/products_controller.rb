class Users::ProductsController < ApplicationController
  def new
    @product = Product.new
  end

  def index
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @products = @category.products.order(created_at: :desc).page(params[:page]).per(16)
    else
      @products = Product.all.order(created_at: :desc).page(params[:page]).per(16)
    end
  end

  def show
    @product = Product.find(params[:id])
    @product_comment = ProductComment.new
    @product_comments = @product.product_comments
    @tradings = Trading.where(product_id: @product.id)
  end

  def create
    @product = Product.new(product_params)
    @product.user_id = current_user.id
    if @product.save
      # tags = Vision.get_image_data(@product.image)
      # tags.each do |tag|
      #   @product.tags.create(name: tag)
      # end
      redirect_to product_path(@product.id)
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to my_product_products_path
    else
      render :edit
    end
  end

  def my_product
    @products = Product.where(user_id: current_user.id, sale_status: 0)
  end

  def destroy
  end

  def search
    if params[:name].present?
      @products = Product.where('name LIKE ?', "%#{params[:name]}%").order(created_at: :desc).page(params[:page]).per(16)
    else
      @products = Product.all.order(created_at: :desc).page(params[:page]).per(16)
    end
  end

  private
  def product_params
    params.require(:product).permit(:category_id, :user_id, :name, :image, :introduction, :status, :price, :profit, :postage, :postage_responsibility, :sale_status, :propriety, :notice, :barter_propriety)
  end
end
