class Users::UsersController < ApplicationController
	before_action :current_user, except: [:delete]

	def show
		@users = User.all
		@user = User.find(params[:id])
		@excellent_count = Trading.group(:excellent_review).count(:excellent_review)
		@good_count = Trading.group(:good_review).count(:good_review)
		@poor_count = Trading.group(:poor_review).count(:poor_review)
		@trading = Trading.where(buyer_id: @user.id)
		@tradings = @user.tradings
		@tradings = Trading.where(seller_id: @user.id)
		@balance = calculate(params[:id])
		@barter_requests = BarterRequest.where(user_id: @user.id )
	end

	def userinfo
		@user = current_user
		@balance = @user.balance
		@products = Product.where(user_id: @user.id)
	end

	def usertransfer
		@user = current_user
		@products = Product.where(user_id: current_user.id)
		@request_amount = User.new
	end

	def create
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
		if @user.request_amount == nil
		  @user.request_amount = 0
		  @user.save
		end
		if @user.balance && @user.request_amount
	  	  @user.balance -= @user.request_amount
	    else
	   	  @user.balance = @user.request_amount
	  	end
	    current_user.save
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
  	def calculate(user_id)
    	products = Product.where(sale_status: 1, user_id: user_id)
    	sum = 0
    	profit = 0
    	products.each do |product|
    		if product.profit != nil
    	  		sum += product.profit
    		end
    	end
    	return sum
  	end

    def user_params
    	params.require(:user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postcode, :prefecture_code, :address_city, :address_street, :address_building, :phone_number, :bank_name, :account_type, :branch_code, :account_number, :account_last_name_kana, :account_first_name_kana, :buyer_id, :seller_id, :balance, :request_amount, :image, :nickname, :introduction)
    end
end


