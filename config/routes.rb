Rails.application.routes.draw do
  resources :invoices do
    delete 'delete', on: :member
  end
  root "invoices#index"
end
