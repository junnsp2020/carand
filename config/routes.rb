Rails.application.routes.draw do
  devise_for :administers
  devise_for :users, :controllers => {
   :registrations => 'users/registrations',
  }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


namespace :administers do
	root "home#top"
	resources :users, except: [:new, :create]
	resources :reports, only: [:index, :show, :destroy]
	resources :tradings, except: [:new, :create]
	resources :categories, except: [:new, :show, :destroy]
end

scope module: :users do
	root "homes#top"
	get "users/userinfo/:id" => "users#userinfo", as: "userinfo_user"
	get "users/usertransfer/:id" => "users#usertransfer", as: "usertransfer_user"
	get "products/my_product" => "products#my_product", as: "my_product_products"
	get "tradings/bought" => "tradings#bought", as: "bought_tradings"
	get "tradings/sold" => "tradings#sold", as: "sold_tradings"
	get "wishlists/wish" => "wishlists#wish", as: "wish_wishlists"
	resources :users, only: [:show, :edit, :update, :create, :delete]
    resources :transfers, except: [:new, :index, :destroy]
    get "/products_search" => "products#search" ,as: "product_search"

	resources :products do
		resource :product_comments
		resource :wishlists
		resource :favorites
		resource :reviews
		resources :tradings
		resources :barter_requests, except: [:edit]
		resources :reports, only: [:new, :create]
	end

	get "requested_barter_requests/requested" => "barter_requests#requested", as: "requested_barter_requests"
	get "my_barter_requests/:user_id" => "barter_requests#my_request", as: "my_request_barter_requests"
	resources :tradings, except: [:destroy] do
		resource :trading_messages
		patch :change_payment_status
		patch :change_shipment_status
	end
	resources :blogs do
		resource :blog_comments
		resource :blog_follows
	end
end
end