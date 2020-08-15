Rails.application.routes.draw do
  resources :sale_imports, only: %i(new create show)
  root 'sale_imports#new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
