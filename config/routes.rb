# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root "invoices#index"
  resources :invoices
  resources :clients, only: [:index]
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
end
