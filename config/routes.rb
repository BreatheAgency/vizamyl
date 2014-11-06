Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  scope ':type', type: /#{%w(videos texts images interactives question_intros image_questions interactive_questions).join("|")}/ do
    get '/:id' => 'pages#show'
  end

  resources :chapters, only: %i(index show)
  resources :progressions, only: %i(create show index update)

  get '/course/:locale/*other' => 'static#show', id: 'course'

  scope ':locale', locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'enrole' }, controllers: { registrations: 'users/registrations' }
    get '/*id' => 'static#show', id: 'home', as: :static
    get '/' => 'static#show', id: 'home'
  end

  get '/*id' => 'static#show', id: 'gatekeeper'
  root to: 'static#show', id: 'gatekeeper'
end
