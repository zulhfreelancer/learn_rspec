Rails.application.routes.draw do
  get 'phones/show'

  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :users
  resources :sessions

  resources :contacts do
  	patch '/hide' => 'contacts#hide', on: :member
  	resources :phones
  end

  root 'contacts#index'
end
