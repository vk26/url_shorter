Rails.application.routes.draw do
  post :url, to: 'links#create'
end
