Rails.application.routes.draw do
  post :urls, to: 'links#create'

  get 'urls/:short_url', to: 'links#redirect'
end
