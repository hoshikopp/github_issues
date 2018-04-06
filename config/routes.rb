Rails.application.routes.draw do
  get 'repositories/index'

  resources :repositories, only: %i( index show destroy update ) do
    post 'search_or_get' => 'repositories#search_or_get', on: :collection
  end
end
