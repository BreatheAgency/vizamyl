Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  %w(interactives texts videos images question_intros interactive_questions image_questions).each do |step_type|
    get "/#{step_type}/:id" => 'steps#show'
  end

  resources :chapters, only: %i(index show)
  resources :progressions, only: %i(create index update)

  scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do
  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'enrole' }, controllers: { registrations: 'users/registrations' }
    get '/course', to: redirect("/%{locale}/course/text/1")
    get '/course/*other' => 'static#show', id: 'course'
    get '/*id' => 'static#show', id: 'home', as: :static
    get '/' => 'static#show', id: 'home'
  end

  get '/*id' => 'static#show', id: 'gatekeeper'
  root to: 'static#show', id: 'gatekeeper'
end
