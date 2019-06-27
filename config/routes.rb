Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'top#index'
  resources :questions, only: [:new, :create, :destroy]
  resources :users, only: [:edit, :update]
  resources :users, only: [:show]
    get 'my_question/:id' => 'users#my_question'
    get 'my_answer/:id' => 'users#my_answer'
    get 'identification/:id' => 'users#identification'
    get 'card/:id' => 'users#card'
    get 'bank/:id' => 'users#bank'

  # 検索
  get 'questions/search' => 'questions#search'
  get 'questions/search_open' => 'questions#search_open'
  get 'questions/search_resolved' => 'questions#search_resolved'

  # カテゴリ
  get 'questions/categories' => 'questions#categories'
  get 'questions/category/:id' => 'questions#category'
  get 'questions/category/:id/category_pv' => 'questions#category_pv'
  get 'questions/category/:id/category_answer_count' => 'questions#category_answer_count'
  get 'questions/category/:id/category_point' => 'questions#category_point'

  get 'questions/category/:id/category_open' => 'questions#category_open'
  get 'questions/category/:id/category_open_pv' => 'questions#category_open_pv'
  get 'questions/category/:id/category_open_answer_count' => 'questions#category_open_answer_count'
  get 'questions/category/:id/category_open_point' => 'questions#category_open_point'


  # ランキング
  get 'questions/ranking' => 'questions#ranking'
  get 'questions/ranking_open' => 'questions#ranking_open'

  # 回答受付中
  get 'questions/open' => 'questions#open'
  get 'questions/open_pv' => 'questions#open_pv'
  get 'questions/open_answer_count' => 'questions#open_answer_count'
  get 'questions/open_point' => 'questions#open_point'


  post 'questions/confirm' => 'questions#confirm'

  # QA詳細
  resources :questions, only: :show do
    resources :answers, only: [:create, :update, :destroy]
    post 'confirm' => 'answers#confirm'
    get 'answers/:id/ba_confirm' => 'answers#ba_confirm'
  end

  # フッター
  get 'privacy_policy' => 'others#privacy_policy'
  get 'rule' => 'others#rule'
  get 'help' => 'others#help'
  get 'contact' => 'others#contact'

end
