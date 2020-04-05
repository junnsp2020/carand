class Users::ProductsController < ApplicationController
  def new
    @product = Product.new
  end

  def index
    # @ranks = Product.find(BarterRequest.group(:product_id).order('count(product_id) desc').limit(5).pluck(:product_id))
    # if params[:category_id]
    #   @category = Category.find(params[:category_id])
    #   @finals = Product.group(:category_id).find(BarterRequest.group(:product_id).order('count(product_id) desc').limit(5).pluck(:product_id))
    #   # @finals = @category.finals
    # end
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @products = @category.products.order(created_at: :desc).page(params[:page]).per(16)
      @ranks = @category.products.find(BarterRequest.group(:product_id).order('count(product_id) desc').limit(5).pluck(:product_id))
    else
      @products = Product.all.order(created_at: :desc).page(params[:page]).per(16)
      @ranks = Product.find(BarterRequest.group(:product_id).order('count(product_id) desc').limit(5).pluck(:product_id))
    end
  end

  def show
    @product = Product.find(params[:id])
    @product_comment = ProductComment.new
    @product_comments = @product.product_comments
    @tradings = Trading.where(product_id: @product.id)
  end

  def create
    if product_params[:image].blank?
      flash[:notice] = "画像が選択されていません"
      redirect_to new_product_path
      return
    end
    @product = Product.new(product_params)
    @product.user_id = current_user.id
    ActiveRecord::Base.transaction do
      unless @product.save
        flash[:notice] = "データの保存に失敗しました<br>"
        @product.errors.full_messages.each do |message|
          flash[:notice] << message << "<br>"
        end

        redirect_to new_product_path
        return
      end
      annotations = Vision.get_image_data(@product.image)
      if !annotations.all?{|_k, v| v == 'VERY_UNLIKELY' || v == 'UNLIKELY' }
        raise ActiveRecord::Rollback
      end
      @product.tags.create(name: 'annotation')
    end
    if @product.persisted?
      redirect_to product_path(@product.id)
    else
      flash[:notice] = "投稿画像が有効ではありません"
      redirect_to new_product_path
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to new_product_path
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
