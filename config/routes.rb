# config/routes.rb

COUNTRY_REDIRECTS = {
  'au' => { subdomain: 'si',  redirect: true  },
  'at' => { subdomain: 'at',  redirect: true  },
  'be' => { subdomain: 'ch',  redirect: true  },
  'bg' => { subdomain: 'ch',  redirect: true  },
  'hr' => { subdomain: 'ch',  redirect: true  },
  'cz' => { subdomain: 'ch',  redirect: true  },
  'dk' => { subdomain: 'ch',  redirect: true  },
  'ee' => { subdomain: 'ch',  redirect: true  },
  'fi' => { subdomain: 'ch',  redirect: true  },
  'fr' => { subdomain: 'fr',  redirect: false },
  'de' => { subdomain: 'de',  redirect: true  },
  'gr' => { subdomain: 'ch',  redirect: true  },
  'hk' => { subdomain: 'si',  redirect: true  },
  'hu' => { subdomain: 'ch',  redirect: true  },
  'il' => { subdomain: 'si',  redirect: true  },
  'it' => { subdomain: 'it',  redirect: true  },
  'jp' => { subdomain: 'jp',  redirect: true  },
  'lu' => { subdomain: 'ch',  redirect: true  },
  'nl' => { subdomain: 'ch',  redirect: true  },
  'no' => { subdomain: 'ch',  redirect: true  },
  'pl' => { subdomain: 'ch',  redirect: true  },
  'sg' => { subdomain: 'si',  redirect: true  },
  'sk' => { subdomain: 'ch',  redirect: true  },
  'si' => { subdomain: 'ch',  redirect: true  },
  'kr' => { subdomain: nil,   redirect: true  },
  'es' => { subdomain: 'es',  redirect: true  },
  'se' => { subdomain: 'ch',  redirect: true  },
  'ch' => { subdomain: 'ch',  redirect: true  },
  'tw' => { subdomain: 'si',  redirect: true  },
  'tr' => { subdomain: 'si',  redirect: true  },
  'gb' => { subdomain: 'uk',  redirect: true  },
  'us' => { subdomain: 'us',  redirect: true  }
}.freeze

Rails.application.routes.draw do
  mount_roboto

  # France maintenance redirect
  get '/fr', to: redirect('/down-for-maintenence.html')
  get '/fr/*path', to: redirect('/down-for-maintenence.html')

  # Country-origin redirects — only register countries marked redirect: true
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

  # Supports:
  # /course/de/menu
  # /course/fr/menu
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

  # All locale-specific routes
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

    # IMPORTANT:
    # Matches /de/course/de/menu before the generic /*id route below.
    #
    # Examples:
    # /de/course/de/menu
    # /fr/course/fr/menu
    # /en-us/course/en-us/menu
    #
    # Outer locale = website/current locale
    # course_locale = locale embedded in the course URL
    get 'course/:course_locale/*other',
        to: 'static#show',
        id: 'course',
        constraints: {
          course_locale: /#{I18n.available_locales.join("|")}/
        }

    # Optional: supports /de/course/menu too.
    get 'course/*other',
        to: 'static#show',
        id: 'course'

    # Generic locale static pages.
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

  # Final fallback
  get '/*id', to: 'static#show', id: 'gatekeeper'
  root to: 'static#show', id: 'gatekeeper'
end