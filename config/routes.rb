Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
    # devise_for :users,
    #            path: '',
    #            controllers: {registrations: 'registrations'}
    namespace :v1 do
     devise_for :users,
               path: '',
               path_names: { sign_in: 'login', sign_out: 'logout', registration: 'signup' },
               controllers: { sessions: 'v1/sessions', registrations: 'v1/registrations', passwords: 'v1/passwords' }
     resources :passwords, only: [:create] do
       member do
         put :reset_password
       end
     end
    end
  # resources :home, only: [:index]
   # root :to => "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
