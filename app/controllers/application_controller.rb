class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :postcode, :prefecture_code, :address_city, :address_street, :address_building, :phone_number, :email, :nickname])
  end
  def after_sign_in_path_for(resource_or_scope)
  	if resource_or_scope.is_a?(Administer)
      administers_root_path
    else
      user_path(current_user)
    end
  end
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :administer
      new_administer_session_path
    else
      root_path
    end
  end
end
