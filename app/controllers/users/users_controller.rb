class Users::UsersController < ApplicationController

	def show
		@users = User.all
		@user = User.find(params[:id])
	end

	def userinfo
		@user = User.find(params[:id])
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
    def user_params
    	params.require(:user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postcode, :prefecture_code, :address_city, :address_street, :address_building, :phone_number, :bank_name, :account_type, :branch_code, :account_number, :account_last_name_kana, :account_first_name_kana)
    end
end


