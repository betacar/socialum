Socialum::Application.routes.draw do
  resources :overview, :only => [:index]

  # Raiz de la app
  root :to => 'baxs#index'

  # Recursos anidados: arribos y descargas
  resources :baxs, :only => [:index, :show] do
    resources :bax_gabarras, :only => [:index]
    get '/bax_gabarras/:gabarra_id' => 'bax_gabarras#show', 
      :constraints => { :gabarra_id => /[A-Z]{2,4}-\d{2,4}/ }, 
      :as => :bax_gabarra

    resources :arribos_bauxitas, :except => [:new, :edit] do
      resources :descargas, :except => [:new, :edit]
    end
  end

  # Recursos de autenticacion
  devise_for :users, :skip => [:sessions]
  as :user do
    get 'login' => 'devise/sessions#new', :as => :new_user_session
    post 'login' => 'devise/sessions#create', :as => :user_session
    match 'logout' => 'devise/sessions#destroy', :as => :destroy_user_session,
      :via => Devise.mappings[:user].sign_out_via
  end

  # Plantilla de recursos
  match '/:controller(/:action(/:id))'
end