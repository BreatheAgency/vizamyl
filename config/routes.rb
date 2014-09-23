Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }, controllers: { registrations: 'users/registrations' }

  %w(videos images).each do |step_type|
    get "/#{step_type}/:id" => 'steps#show'
  end

  resources :chapters, only: %i(index show)
  resources :progressions, only: %i(create index)


  get '/course', to: redirect('/course/start')
  get '/course/*other' => 'static#show', id: 'course'
  get '/*id' => 'static#show', as: :static
  root to: 'static#show', id: 'home'
end
