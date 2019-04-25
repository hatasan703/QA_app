Rails.application.routes.draw do
  devise_for :users
  root 'top#index'
  resources :questions, only: [:new, :create]
  get 'questions/categories' => 'questions#categories'
  get 'questions/category/:id' => 'questions#category'
  get 'questions/ranking' => 'questions#ranking'
  get 'questions/open' => 'questions#open'
end




# get 'questions' => 'questions#index'
# get 'questions/new' => 'questions#new'
# post 'questions' => 'questions#create'
# get 'users/:id' => 'users#show'
# delete 'questions/:id' => 'questions#destroy'
# patch 'questions/:id' => 'questions#update'
# get 'questions/:id/edit' => 'questions#edit'
# get 'questions/:id' => 'questions#show'




# Rails.application.routes.draw do
#   devise_for :users, controllers: {
#     registrations: 'users/registrations',
#     omniauth_callbacks: "users/omniauth_callbacks"
#   }
#   # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
#   root to: 'products#index'
#   resources :mypage, only: [:index]
#   resources :products do
#     resources :purchase, only: [:new, :create], module: :products
#     resource :publications, only: [:update, :destroy], module: :products
#   end
#   resources :users, only: :edit

#   namespace :users do
#     namespace :sign_up do
#       get 'address', to: 'address#new'
#       get 'payment_methods', to: 'payment_methods#new'
#       get 'registration', to: 'registration#new'

#       resources :address, only: [:create]
#       resources :payment_methods, only: [:create]
#       resources :done, only: [:index]
#     end
#   end
# end
