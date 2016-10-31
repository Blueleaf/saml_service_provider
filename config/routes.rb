Rails.application.routes.draw do
  get '/sso/init' => 'saml#init'
  post '/sso/consume' => 'saml#consume'

  root to: 'home#index'
end
