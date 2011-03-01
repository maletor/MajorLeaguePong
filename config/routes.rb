MajorLeaguePong::Application.routes.draw do
  match 'signup/:invitation_token' => "users#new", :as => :signup_with_invite
  match 'signup' => 'users#new', :as => :signup
  match 'logout' => 'sessions#destroy', :as => :logout
  match 'login' => 'sessions#new', :as => :login
  match 'user/edit' => 'users#edit', :as => :edit_current_user

  resources :invitations
  resources :visuals
  resources :sessions
  resources :users
  resources :players
  resources :teams
  resources :rounds  

  resources :games do
    resources :rounds
    resources :shots
  end

  root :to => "players#index"
end
