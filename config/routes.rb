require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  devise_for :users, controllers: { registrations: 'registrations', omniauth_callbacks: 'omniauth_callbacks' }

  root 'day_subjects#index'

  resources :day_subjects
  resources :social_publications, only: :create

  namespace :api do
    namespace :public do
      resources :profiles, only: :show
    end
  end

  namespace :account do
    resources :statistics, only: :index
    resources :users,      only: [:show, :edit, :update]
  end
end
