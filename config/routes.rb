Rails.application.routes.draw do
  get 'pages/index'
  resources :publications # Borrar except: :create si no funciona
  devise_for :users, except: :create, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  post '/new_user_postulation', to: 'publications#new_user_postulation', as: 'new_user_postulation'
  get '/mispostulaciones', to: 'publications#mypostulations', as: 'user_postulations'
  get '/registrar_usuario', to: 'publications#register_user', as: 'register_user'
  post '/crear_usuario', to: 'publications#create_user', as: 'create_user'
  get '/portal_postulaciones', to: 'pages#index'
  get '/postulaciones_recibidas', to: 'publications#users_postulations', as: 'postulations_received'
  # Defines the root path route ("/")
  # root "articles#index"

  root "pages#index" # Quizás sea necesario redirigir a otra página "home#index" en caso de no estar con sesión iniciada
end
