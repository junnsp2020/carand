class Users::WishlistsController < ApplicationController

  def create
  	@product = Product.find(params[:product_id])
  	@product.save
  	@wishlist = Wishlist.new(product_id: @product.id)
    @wishlist.user_id = current_user.id
    @wishlist.save
    redirect_to request.referer
  end

  def destroy
    @product = Product.find(params[:product_id])
    @wishlist = current_user.wishlists.find_by(product_id: @product.id)
    @wishlist.destroy
    redirect_to request.referer
  end

  def wish
  	@wishlists = Wishlist.where(user_id: current_user.id)
  end

  private
  def wishlist_params
    params.require(:wishlist).permit(:user_id, :product_id)
  end
end
