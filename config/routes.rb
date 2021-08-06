Rails.application.routes.draw do
  get 'user/new'
  get '/' => "playlist#index"
  get "/search" => "youtube#search"
  get "/playlist/:playlist_id/video/delete/:id" => "youtube#delete"
  get "/new/playlist" => "playlist#new"
  post "/create/playlist" => "playlist#create"
  get "/delete/:id" => "playlist#delete"
  get "/playlist/:id/detail" => "playlist#detail"
  get "/playlist/:id/autoplay" => "playlist#autoplay"
  post "playlist/:playlist_id/register/:video_id" => "playlist#register"
  get "/signup" => "user#new"
  post "/users/create" => "user#create"
  get "/login_form" => "user#login_form"
  post "login" => "user#login"
  get "/logout" => "user#logout"
  get "/user/:id/edit" => "user#edit"
  post "/user/:id/update" => "user#update"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
