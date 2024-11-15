# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'invoices#index'
  resources :invoices do
    delete 'delete', on: :member
  end
  resources :clients, only: [:index]
end
