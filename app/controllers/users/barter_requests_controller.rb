class Users::BarterRequestsController < ApplicationController
  def new
    @product = Product.find(params[:product_id])
    @barter_request = BarterRequest.new
  end

  def index
  	@product = Product.find(params[:product_id])
  	@barter_requests =  @product.barter_requests
    @barter_request = BarterRequest.new
    @barter_request.user_id = current_user.id
    @buyer = BarterRequest.where(buyer_id: current_user.id)
    @seller = BarterRequest.where(seller_id: @product.user.id)
    @barter_request.product_id = @product.id
    # params[:barter_request_id]
    # params[:barter_request_id]
    # @barter_requests = @product.barter_requests
  end

  def show
    @product = Product.find(params[:product_id])
    @barter_requests =  @product.barter_requests
    # @barter_request = BarterRequest.new
    @barter_request = BarterRequest.find(params[:id])
    # @barter_requests = BarterRequest.new
  end

  def create
    @product = Product.find(params[:product_id])
    @barter_request = BarterRequest.new(barter_request_params)
    @barter_request.product_id = @product.id
    @barter_request.user_id = current_user.id
    @product.notice = false
    @product.save
    if @barter_request.save
      redirect_to product_barter_requests_path
    else
      render :new
    end
  end

  def update
    @barter_request = BarterRequest.find(params[:id])
    @product = Product.find(params[:product_id])
    if @barter_request.update(barter_request_params)
      @product.barter_approval = true
      @product.save
      redirect_to  request.referer
    else
      render :show
    end
  end

  def my_request
     # @product = Product.find(params[:product_id])
    # @barter_requests =  @product.barter_requests
    @barter_requests = BarterRequest.where(user_id: params[:user_id])
    # @barter_request.product_id = @product.id
    # @barter_request.user_id = current_user.id
    # @barter_request = BarterRequest.find(params[:id])
  end

  def requested
    @product = Product.where(user_id: current_user.id)
    # barter_requests = BarterRequest.all
    @barter_requests = BarterRequest.where(product_id: @product)
    # @barter_requests = @product.barter_requests
    # @product.barter_requests.product_id = @product.id
  end

  def destroy
  end

  private
  def barter_request_params
    params.require(:barter_request).permit(:product_id, :user_id, :name, :image, :introduction, :comment, :product_condition, :propriety, :buyer_id, :seller_id, :notice)
  end
end
