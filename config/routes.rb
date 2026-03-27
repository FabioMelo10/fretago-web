Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  root "home#index"

  resources :pedidos, only: %i[index show new create] do
    resources :propostas, only: %i[new create]
    member do
      patch :aceitar_proposta
      patch :atualizar_status
      get :sucesso
    end
  end

  resources :motoristas, only: %i[new create]

  namespace :api do
    namespace :v1 do
      resources :pedidos, only: %i[index show create] do
        resources :propostas, only: %i[create]
      end
      resources :motoristas, only: %i[index show create]
      resources :propostas, only: %i[index show] do
        member do
          patch :aceitar
        end
      end
    end
  end
end

