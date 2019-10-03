Rails.application.routes.draw do
  get 'import/index'
  root 'import#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
