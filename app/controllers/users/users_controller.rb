class Users::UsersController < ApplicationController

	def show
		@users = User.all
		@user = User.find(params[:id])
		@excellent_count = Trading.group(:excellent_review).count(:excellent_review)
		@good_count = Trading.group(:good_review).count(:good_review)
		@poor_count = Trading.group(:poor_review).count(:poor_review)
		@trading = Trading.where(buyer_id: current_user.id)
		@tradings = @user.tradings
		@tradings = Trading.where(seller_id: current_user.id)
		# # @excellent_count = @user.excellent_count  #追加   #一旦コメントアウト
		# # @good_count = @user.good_count  #追加   #一旦コメントアウト
		# # @poor_count = @user.poor_count  #追加   #一旦コメントアウト
		# @product = Product.where(user_id: current_user.id) #追加
		# @excellent_count = @product.excellent_count  #追加
		# @good_count = @product.good_count  #追加
		# @poor_count = @product.poor_count  #追加
	    # @excellent_count = Trading.where(excellent_review: "false").where(buyer_id: current_user.id)
	end

	def userinfo
		@user = User.find(current_user.id)
		@balance = User.new
		@balance = calculate(current_user)
		@products = Product.where(user_id: current_user.id)
	end

	def create
		@balance = User.new(user_params)
		@balance.save
	end

	def edit
		@user = User.find(params[:id])
		if @user.id != current_user.id
        redirect_to user_path(current_user)
        end
	end

	def update
	  	@user = User.find(params[:id])
	    if @user.update(user_params)
	  		redirect_to user_path(@user.id)
	  	else
	  		render :edit
	  	end
  end

    private
    def calculate(current_user)
		@balance = 0
		@user.products.each do |product|
		@balance += product.profit
    	end
  	end

    def user_params
    	params.require(:user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postcode, :prefecture_code, :address_city, :address_street, :address_building, :phone_number, :bank_name, :account_type, :branch_code, :account_number, :account_last_name_kana, :account_first_name_kana, :buyer_id, :seller_id, :balance)
    end
end


