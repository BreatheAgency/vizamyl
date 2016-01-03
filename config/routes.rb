Rails.application.routes.draw do
  mount_roboto

  get '/upgrade' => 'errors#upgrade'

  get 'errors/file_not_found'
  get 'errors/unprocessable'
  get 'errors/internal_server_error'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  scope ':type', type: /#{%w(videos texts images interactives question_intros).join("|")}/ do
    get '/:id' => 'pages#show'
  end

  resources :tests, only: %i(show)
  resources :four_bs, only: %i(show)
  resources :chapters, only: %i(index show)
  resources :progressions, only: %i(create show index update)

  get '/course/:locale/*other' => 'static#show', id: 'course'

  scope 'admin' do
    get 'become', to: 'admin/become#become'
  end

  scope ':locale', locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout' }, controllers: { registrations: 'users/registrations' }
    namespace :users do
      resources :enrol, only: [:new, :create, :show, :update]
      get '/course-complete' => 'course_completion#success'
    end
    get '/*id' => 'static#show', id: 'home', as: :static
    get '/' => 'static#show', id: 'home'
  end

  match '/404', to: 'errors#file_not_found', via: [:get, :post]
  match '/422', to: 'errors#unprocessable', via: [:get, :post]
  match '/500', to: 'errors#internal_server_error', via: [:get, :post]

  get 'sitemap.xml', to: 'sitemap#index', defaults: { format: 'xml' }

  get '/*id' => 'static#show', id: 'gatekeeper'
  root to: 'static#show', id: 'gatekeeper'
end
