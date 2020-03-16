class Users::UsersController < ApplicationController
	before_action :current_user, except: [:delete]

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
		@balance = calculate(current_user)
		@products = Product.where(user_id: current_user.id)
	end

	def usertransfer
		@user = User.find(current_user.id)
		@products = Product.where(user_id: current_user.id)
		@request_amount = current_user
	end

	def create
		@balance = User.new(user_params)
		@balance.save
		@request_amount = User.new(user_params)
		@request_amount.save
	end

	def edit
		@user = User.find(params[:id])
		if @user.id != current_user.id
        redirect_to user_path(current_user)
        end
	end

	def update
		@user = User.find(params[:id])
	  	@user.update(user_params)
	  	current_user.request_amount = current_user.request_amount + user_params[:request_amount].to_i
	  	current_user.save
	  	redirect_to user_path(current_user.id)
  	end

  	def delete
  		user = User.find(current_user.id)
        user.is_deleted = true
        user.save
        redirect_to products_path
  	end

    private
    def calculate(current_user)
		balance = 0
		profit = 0
		request_amount = 0
		current_user.products.each do |product|
			if product.profit != nil && product.sale_status == "売り切れ"
				balance += product.profit
			end
    	end
    	if current_user.balance != nil && current_user.request_amount != nil
    	balance -= current_user.request_amount
        end
    	return balance
  	end

    def user_params
    	params.require(:user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postcode, :prefecture_code, :address_city, :address_street, :address_building, :phone_number, :bank_name, :account_type, :branch_code, :account_number, :account_last_name_kana, :account_first_name_kana, :buyer_id, :seller_id, :balance, :request_amount, :is_deleted)
    end
end


