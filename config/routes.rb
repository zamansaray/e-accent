Rails.application.routes.draw do
  devise_scope :user do
    root to: 'devise/sessions#new'
  end

  devise_for :users, controllers: { registrations: "users/registrations" }

  resource  :dashboard, only: [:show]
  resource  :search, only: [:show]
  resources :worker_skills, only: [:index, :new, :create, :destroy]
end
