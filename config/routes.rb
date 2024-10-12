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
      resources :patients do
        member do
          get 'medical_record'
          get 'visits'
        end
      end

      resources :departments
      resources :doctors
      resources :visits
      resources :laboratory_results
    end
  end

  get 'up' => 'rails/health#show', as: :rails_health_check
  match '*path', to: 'application#handle_no_route_found', via: :all
end
