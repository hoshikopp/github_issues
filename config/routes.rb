Rails.application.routes.draw do
  resources :repositories, only:[:index, :show] do
    post    '/search_or_get' => 'repositories#search_or_get', on: :collection
  end
end
