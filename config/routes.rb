Rails.application.routes.draw do
  devise_for :users
  root "items#index"
  resources  :items do 
    collection do
      get 'look'
      get 'search'
    end
    resources :orders, only: [:index, :create]
  end
end
