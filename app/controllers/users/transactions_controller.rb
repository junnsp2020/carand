class Users::TransactionsController < ApplicationController
  def new
    @product = Product.find(params[:product_id])
    @transactions = @product.transactions
    @transaction = Transaction.new
    @users = User.where(user_id: current_user.id)
  end

  def index
  end

  def show
  end

  def create
    @product = Product.find(params[:product_id])
    @transaction = Transaction.new(transaction_params)
    @transaction.product_id = @product.id
    @transaction.user_id = current_user.id
    if @transaction.save
      redirect_to product_path(@product.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  private
  def transaction_params
    params.require(:transaction).permit(:product_id, :user_id, :status, :price, :profit, :paymethod)
end
end
