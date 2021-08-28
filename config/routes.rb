Rails.application.routes.draw do
  post :urls, to: 'links#create'

  get 'urls/:short_url', to: 'links#redirect'
  get 'urls/:short_url/stats', to: 'links#stats'
end
