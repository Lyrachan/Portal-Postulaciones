Rails.application.routes.draw do
  resources :publications
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  post '/new_user_postulation', to: 'publications#new_user_postulation', as: 'new_user_postulation'
  # Defines the root path route ("/")
  # root "articles#index"

  root "publications#index" # Quizás sea necesario redirigir a otra página "home#index" en caso de no estar con sesión iniciada
end
