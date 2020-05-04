class Users::ProductCommentsController < ApplicationController
  def create
  	@product = Product.find(params[:product_id])
  	@product_comments = @product.product_comments
	  @product_comment = current_user.product_comments.new(product_comment_params)
    @product_comment.product_id = @product.id
    @product_comment.save
    redirect_to product_path(@product)
  end

  private
  def product_comment_params
    params.require(:product_comment).permit(:comment, :user_id, :product_id)
  end
end
