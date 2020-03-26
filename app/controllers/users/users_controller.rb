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
		# binding.pry
		@balance = @user.balance
		# @balance = calculate(current_user)   ## => 計算してるだけ
		# @product = Product.find(params[:product_id])
		@barter_requests = BarterRequest.where(user_id: current_user.id )
		# product = Product.find(params[:product_id])
	end

	def userinfo
		@user = current_user
		@balance = @user.balance
		@products = Product.where(user_id: @user.id)
	end

	def usertransfer
		@user = current_user
		@products = Product.where(user_id: current_user.id)
		@request_amount = @user.request_amount
		@balance = @user.balance
		# @user = current_user
		# @products = Product.where(user_id: @user.id)
		# @balance = calculate(current_user)
		# # @request_amount = User.new

		# @user.request_amount = params[:request_amount].to_i
		# if @user.request_amount && @balance
		# 	@balance -= @user.request_amount
		# end
		# @user.save
		# if current_user.request_amount
	 #  		current_user.request_amount += user_params[:request_amount].to_i
	 #  	else
	 #  		current_user.request_amount = user_params[:request_amount].to_i
	 #  	end
		# @balance = calculate(@user)
	end

	def create
		@balance = calculate(current_user)
		@request_amount = User.new(user_params)
		@request_amount.save
		# binding.pry
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
		@user.update(user_params)
	    @user.balance = calculate(@user)
		 if current_user.request_amount
	  	   current_user.request_amount += user_params[:request_amount].to_i
	     else
	   	   current_user.request_amount = user_params[:request_amount].to_i
	  	end
	    # @balance = calculate(@user)
	if @user.save
	  	redirect_to user_path(current_user.id)
	else
			render :show
	end
	end

  	def delete
  		user = User.find(current_user.id)
        user.is_deleted = true
        user.save
        redirect_to products_path
  	end

    private
  #   def calculate(user)
		# user.balance -= user.request_amount
  # 	end
  	def calculate(user)
		balance = 0
		profit = 0
		request_amount = 0
		user.products.each do |product|
			# binding.pry
			if product.profit != nil && product.sale_status == "売り切れ"
				balance += product.profit
				# binding.pry
				balance.save
			end
    	end
    	# binding.pry
    	if balance != nil && current_user.request_amount != nil
    		balance -= current_user.request_amount
        end
    	return balance
  	end

    def user_params
    	params.require(:user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postcode, :prefecture_code, :address_city, :address_street, :address_building, :phone_number, :bank_name, :account_type, :branch_code, :account_number, :account_last_name_kana, :account_first_name_kana, :buyer_id, :seller_id, :balance, :request_amount, :image, :nickname)
    end
end


