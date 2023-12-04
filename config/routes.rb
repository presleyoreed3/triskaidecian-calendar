Rails.application.routes.draw do

  get "about", to: "about#index"
  get "converter", to: "converter#index"
  root to: "main#index"

end
