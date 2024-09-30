Rails.application.routes.draw do
  devise_for :users, path: 'api/v1/auth', path_names: {
    sign_in:      'login',
    sign_out:     'logout',
    registration: 'signup'
  }, controllers: {
    sessions:      'api/v1/auth/sessions',
    registrations: 'api/v1/auth/registrations'
  }

  namespace :api do
    namespace :v1 do
      resources :patients
      resources :departments
    end
  end

  get 'up' => 'rails/health#show', as: :rails_health_check
  match '*unmatched', to: 'application#no_route_found', via: :all
end
