Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: :registrations }

  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :user, only: [:show]

  resource :seller, only: [:new, :create, :edit, :update, :show]
  namespace :seller do
    resources :invoices, only: [:new, :create, :index, :show, :update, :destroy]
    resources :expenses, only: [:new, :create, :update, :edit, :destroy, :index]
    resources :invoice_payers, only: [:new, :create, :destroy, :show, :index, :edit, :update]
  end

  resource :investor, only: [:new, :create, :edit, :update, :show]
  namespace :investor do
    resources :invoices, only: [:index, :show] do
      resources :orders, only: [:create]
    end
    resources :orders, only: [:index]
  end



  get "expenses_chart", to: 'charts#expenses_chart'
  get "incomes_chart", to: 'charts#incomes_chart'
  get "calc_expenses_chart", to: 'charts#calc_expenses_chart'

  mount Attachinary::Engine => "/attachinary"
end
