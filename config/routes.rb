Rails.application.routes.draw do

  get 'welcome/index'

  resources :users
  resources :hotels

	#match '/api/*all', controller: 'application', action: 'options_handler', via: :options

	devise_for :users
	root to: 'welcome#index'

	namespace :api, defaults: {format: :json} do
		namespace :v1 do
			devise_for :users
			get 'hotels' => 'hotels#index'
		end
	end

end
