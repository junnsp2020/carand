class Users::BarterRequestsController < ApplicationController
  def new
    @product = Product.find(params[:product_id])
    @barter_request = BarterRequest.new
  end

  def index
  	@product = Product.find(params[:product_id])
  	@barter_requests =  BarterRequest.all
    @barter_request = BarterRequest.new
    @barter_request.user_id = current_user.id
    # params[:barter_request_id]
    # params[:barter_request_id]
    # @barter_requests = @product.barter_requests
  end

  def show
    @barter_request = BarterRequest.find(params[:id])
  end

  def create
    @product = Product.find(params[:product_id])
    @barter_request = BarterRequest.new(barter_request_params)
    @barter_request.product_id = @product.id
    @barter_request.user_id = current_user.id
    if @barter_request.save
      redirect_to product_barter_requests_path
    else
      render :new
    end
  end

  def update
    @barter_request = BarterRequest.find(params[:id])
    if @barter_request.update(barter_request_params)
      redirect_to  request.referer
    else
      render :show
    end
  end

  def destroy
  end

  private
  def barter_request_params
    params.require(:barter_request).permit(:product_id, :user_id, :name, :image, :introduction, :comment, :product_condition, :propriety)
  end
end
