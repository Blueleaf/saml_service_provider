Rails.application.routes.draw do
  get '/sso/init' => 'saml#init'
  post '/sso/consume' => 'saml#consume'

  get 'signout' => 'home#signout'

  root to: 'home#index'
end
