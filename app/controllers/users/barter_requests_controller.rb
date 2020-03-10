class Users::BarterRequestsController < ApplicationController
  def index
  	@product = Product.find(params[:product_id])
  	@barter_request = BarterRequest.new
  	@barter_requests = @product.barter_requests
  end

  def show
  end

  def create
    @product = Product.find(params[:product_id])
    @barter_request = Barter_request.new(barter_request_params)
    @barter_request.product_id = @product.id
    @barter_request.user_id = current_user.id
    if @barter_request.save
      redirect_to products_path
    else
      render :new
    end
  end

  def destroy
  end

  private
  def barter_request_params
    params.require(:barter_request).permit(:product_id, :user_id, :name, :image_id, :introduction)
  end
end
