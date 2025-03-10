Rails.application.routes.draw do

  mount_roboto
  get '/upgrade' => 'errors#upgrade'
  get 'sitemap.xml', to: 'sitemap#index', defaults: { format: 'xml' }

  get 'errors/file_not_found'
  get 'errors/unprocessable'
  get 'errors/internal_server_error'
  match '/404', to: 'errors#file_not_found', via: [:get, :post]
  match '/422', to: 'errors#unprocessable', via: [:get, :post]
  match '/500', to: 'errors#internal_server_error', via: [:get, :post]

  devise_for :admin_users, ActiveAdmin::Devise.config.merge(controllers: {sessions: 'admin_users/sessions'})

  ActiveAdmin.routes(self)

  scope ':type', type: /#{%w(videos texts images interactives question_intros).join("|")}/ do
    get '/:id' => 'pages#show'
  end

  resources :tests, only: %i(show)
  resources :four_bs, only: %i(show)
  resources :chapters, only: %i(index show)
  resources :progressions, only: %i(create show index update)

  get '/course/:locale/*other' => 'static#show', id: 'course'

  # if !Rails.env.production?
    scope 'admin' do
      get 'become', to: 'admin/become#become'
    end
  # end

  # European
  scope ':locale', locale: /#{I18n.available_locales.reject {|x| x == :"en-us" || x == :"jp"}.join("|")}/ do
    scope module: 'european' do
      resources :enrol, only: [:new, :create, :show, :update], as: 'european_enrol'
    end
  end

  # Non European
  scope ':locale', locale: /en-us|jp/ do
    scope module: 'non_european' do
      resources :enrol, only: [:new, :create, :show, :update], as: 'non_european_enrol'
    end
  end

  # All locales
  scope ':locale', locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users,
               path_names: { sign_in: 'login', sign_out: 'logout' },
               controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }

    namespace :users do
      get '/course-complete' => 'course_completion#success'
      get '/use' => 'course_completion#adjunctive_use_of_quantification'
      get '/refresher' => 'course_completion#refresher_video'
    end
    get '/*id' => 'static#show', id: 'home', as: :static
    get '/' => 'static#show', id: 'home'
  end

  get '/be' => 'static#show', id: 'gatekeeper-belgian'
  get '/ch' => 'static#show', id: 'gatekeeper-swiss'
  get '/us' => 'static#show', id: 'gatekeeper-us'
  get '/si' => 'static#show', id: 'gatekeeper-slovenian'
  get '/bg' => 'static#show', id: 'gatekeeper-bulgaria'
  get '/*id' => 'static#show', id: 'gatekeeper'
  root to: 'static#show', id: 'gatekeeper'
end
