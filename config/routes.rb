Rails.application.routes.draw do
  resources :publications # Borrar except: :create si no funciona
  devise_for :users, except: :create, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  post '/new_user_postulation', to: 'publications#new_user_postulation', as: 'new_user_postulation'
  get '/mispostulaciones', to: 'publications#mypostulations', as: 'user_postulations'
  post '/crear_usuario'
  # Defines the root path route ("/")
  # root "articles#index"

  root "publications#index" # Quizás sea necesario redirigir a otra página "home#index" en caso de no estar con sesión iniciada
end
