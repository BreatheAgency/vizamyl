# config/routes.rb

COUNTRY_REDIRECTS = {
  'au' => { subdomain: 'si', locale: 'en',    redirect: true  },
  'at' => { subdomain: 'at', locale: 'de-at', redirect: true  },
  'be' => { subdomain: 'ch', locale: 'fr',    redirect: true  },
  'bg' => { subdomain: 'ch', locale: 'en',    redirect: true  },
  'hr' => { subdomain: 'ch', locale: 'en',    redirect: true  },
  'cz' => { subdomain: 'ch', locale: 'en',    redirect: true  },
  'dk' => { subdomain: 'ch', locale: 'en',    redirect: true  },
  'ee' => { subdomain: 'ch', locale: 'en',    redirect: true  },
  'fi' => { subdomain: 'ch', locale: 'en',    redirect: true  },
  'fr' => { subdomain: 'fr', locale: 'fr',    redirect: false },
  'de' => { subdomain: 'de', locale: 'de',    redirect: true  },
  'gr' => { subdomain: 'ch', locale: 'en',    redirect: true  },
  'hk' => { subdomain: 'si', locale: 'en',    redirect: true  },
  'hu' => { subdomain: 'ch', locale: 'en',    redirect: true  },
  'il' => { subdomain: 'si', locale: 'en',    redirect: true  },
  'it' => { subdomain: 'it', locale: 'it',    redirect: true  },
  'jp' => { subdomain: 'jp', locale: 'jp',    redirect: true  },
  'lu' => { subdomain: 'ch', locale: 'fr',    redirect: true  },
  'nl' => { subdomain: 'ch', locale: 'en',    redirect: true  },
  'no' => { subdomain: 'ch', locale: 'en',    redirect: true  },
  'pl' => { subdomain: 'ch', locale: 'en',    redirect: true  },
  'sg' => { subdomain: 'si', locale: 'en',    redirect: true  },
  'sk' => { subdomain: 'ch', locale: 'en',    redirect: true  },
  'si' => { subdomain: 'ch', locale: 'en',    redirect: true  },
  'kr' => { subdomain: nil,  locale: 'en',    redirect: true  },
  'es' => { subdomain: 'es', locale: 'es',    redirect: true  },
  'se' => { subdomain: 'ch', locale: 'en',    redirect: true  },
  'ch' => { subdomain: 'ch', locale: 'de',    redirect: true  },
  'tw' => { subdomain: 'si', locale: 'en',    redirect: true  },
  'tr' => { subdomain: 'si', locale: 'en',    redirect: true  },
  'gb' => { subdomain: 'uk', locale: 'en',    redirect: true  },
  'us' => { subdomain: 'us', locale: 'en-us', redirect: true  }
}.freeze

Rails.application.routes.draw do
  mount_roboto

  # France maintenance redirect
  get '/fr', to: redirect('/down-for-maintenence.html')
  get '/fr/*path', to: redirect('/down-for-maintenence.html')

  # Country-origin redirects
  COUNTRY_REDIRECTS.select { |_, value| value[:redirect] }.each_key do |code|
    get "/#{code}", to: 'redirects#country', defaults: { origin: code }
  end

  get '/upgrade', to: 'errors#upgrade'
  get 'sitemap.xml', to: 'sitemap#index', defaults: { format: 'xml' }

  get 'errors/file_not_found'
  get 'errors/unprocessable'
  get 'errors/internal_server_error'

  match '/404', to: 'errors#file_not_found', via: [:get, :post]
  match '/422', to: 'errors#unprocessable', via: [:get, :post]
  match '/500', to: 'errors#internal_server_error', via: [:get, :post]

  devise_for :admin_users,
             ActiveAdmin::Devise.config.merge(
               controllers: { sessions: 'admin_users/sessions' }
             )

  ActiveAdmin.routes(self)

  scope ':type',
        type: /#{%w[videos texts images interactives question_intros].join("|")}/ do
    get '/:id', to: 'pages#show'
  end

  resources :tests, only: [:show]
  resources :four_bs, only: [:show]
  resources :chapters, only: [:index, :show]
  resources :progressions, only: [:create, :show, :index, :update]

  # Course pages
  get '/course/:locale/*other',
      to: 'static#show',
      id: 'course',
      constraints: {
        locale: /#{I18n.available_locales.join("|")}/
      }

  scope 'admin' do
    get 'become', to: 'admin/become#become'
  end

  # European enrolment
  scope ':locale',
        locale: /#{I18n.available_locales.reject { |locale|
          locale == :'en-us' || locale == :jp
        }.join("|")}/ do
    scope module: 'european' do
      resources :enrol,
                only: [:new, :create, :show, :update],
                as: 'european_enrol'
    end
  end

  # Non-European enrolment
  scope ':locale', locale: /en-us|jp/ do
    scope module: 'non_european' do
      resources :enrol,
                only: [:new, :create, :show, :update],
                as: 'non_european_enrol'
    end
  end

  # Localised pages and authentication
  scope ':locale', locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users,
               path_names: {
                 sign_in: 'login',
                 sign_out: 'logout'
               },
               controllers: {
                 registrations: 'users/registrations',
                 sessions: 'users/sessions'
               }

    namespace :users do
      get '/course-complete', to: 'course_completion#success'
      get '/use', to: 'course_completion#adjunctive_use_of_quantification'
      get '/refresher', to: 'course_completion#refresher_video'
    end

    get '/*id',
        to: 'static#show',
        id: 'home',
        as: :static,
        constraints: lambda { |req|
          !req.path.include?('/users/') &&
            !req.path.include?('/login') &&
            !req.path.include?('/logout')
        }

    get '/', to: 'static#show', id: 'home'
  end

  # Gatekeeper pages
  get '/be', to: 'static#show', id: 'gatekeeper-belgian'
  get '/ch', to: 'static#show', id: 'gatekeeper-swiss'
  get '/us', to: 'static#show', id: 'gatekeeper-us'
  get '/si', to: 'static#show', id: 'gatekeeper-slovenian'
  get '/bg', to: 'static#show', id: 'gatekeeper-bulgaria'

  get '/*id', to: 'static#show', id: 'gatekeeper'
  root to: 'static#show', id: 'gatekeeper'
end