Socialum::Application.routes.draw do
  root :to => 'overview#index'
  resources :transportes
  resources :tipo_transportes
  resources :subprocesos
  resources :procesos
  resources :buques
  resources :equipos
  resources :alarmas
  resources :stock_gabarras
  resources :estatus_gabarras
  resources :locacions
  resources :tipo_materias
  resources :arribos
  resources :descargar
  resources :novedades

  # Devise stuff
  # match 'users' => '#index', :as => :devise_for

  # match 'users' => '#index', 
  #       :as => :devise_for, 
  #       :path_names => { :sign_in => 'login', :sign_out => 'logout' }

  # match '/overview' => 'overview#index', 
  #       :as => :user_root

  devise_for :users

  # as :user do
  #   get "login" => "devise/session#new", :as => :new_user_session
  #   post 'login' => 'devise/sessions#create', :as => :user_session
  #   delete "logout" => "devise/sessions#destroy", :as => :destroy_user_session
  # end

  match '/:controller(/:action(/:id))'

  match 'arribos/:action/:num_zarpe/:anio_zarpe' => 'arribos#reportar', 
        :num_zarpe => /\d{3}/, 
        :anio_zarpe => /\d{4}/
        
  match 'arribos/:action/:num_zarpe/:anio_zarpe' => 'arribos#gabarras', 
        :num_zarpe => /\d{3}/, 
        :anio_zarpe => /\d{4}/
        
  match 'arribos/:action/:num_zarpe/:anio_zarpe/:gabarra_id' => 'arribos#gabarra', 
        :as => :arribos_gabarra, 
        :gabarra_id => /(\w{2,5})-(\d{3,4}|\w{4})/, 
        :num_zarpe => /\d{3}/, 
        :anio_zarpe => /\d{4}/
        
  match 'descargar/:action/:num_zarpe/:anio_zarpe/:gabarra_id(.:format)' => 'descargar#gabarra', 
        :gabarra_id => /(\w{2,5})-(\d{3,4}|\w{4})/, 
        :num_zarpe => /\d{3}/, 
        :anio_zarpe => /\d{4}/
        
  match 'descargar/:action/:tipo_materia_id/:buque_id' => 'descargar#buque', 
        :tipo_materia_id => /\d{1,}/, 
        :buque_id => /\d{1,}/
end
