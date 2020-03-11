Rails.application.routes.draw do
  devise_for :administers
  devise_for :users, :controllers => {
   :registrations => 'users/registrations',
  }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


namespace :administers do
	resources :users, except: [:new, :create]
	resources :reports, only: [:index, :show, :destroy]
	resources :tradings, except: [:new, :create]
	resources :categories, except: [:new, :show, :destroy]
end

scope module: :users do
	get "users/userinfo/:id" => "users#userinfo", as: "userinfo_user"
	get "tradings/bought" => "tradings#bought", as: "bought_tradings"
	get "tradings/sold" => "tradings#sold", as: "sold_tradings"
	resources :users, only: [:show, :edit, :update]
	resources :reports, only: [:new, :create]
    resources :transfers, except: [:new, :index, :destroy]

	resources :products do
		resource :product_comments
		resource :wishlists
		resource :favorites
		resource :reviews
		resources :tradings
		resources :barter_requests, except: [:edit, :update]
	end
	resources :tradings, except: [:destroy] do
		resource :trading_messages
	end
	resources :blogs do
		resource :blog_comments
		resource :blog_follows
	end
end
end