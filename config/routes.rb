Rails.application.routes.draw do
  resources :events
  get 'meetings_members/index'
  resources :members
  root 'pages#home'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # resources :meetings
  # resources :meetings do
  #   get 'attendance', on: :collection
  # end
  resources :meetings do
    get 'member_view', on: :collection
    #delete 'remove_member', to: 'meetings#remove_member_from_meeting', as: 'remove_member_from_meeting'
  end
  resources :meetings_members do
    delete 'remove_member_from_meeting', on: :collection, as: 'remove_member_from_meeting_meetings_member'
  end
    
  resources :links
  # resources :events_members
  resources :events_members, only: [:index, :create]

  resources :events_members do
    delete 'remove_member_from_event', on: :collection
  end

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'

  get 'login2', to: 'sessions#new2'

  # for exporting table data
  get 'meetings_export', to: 'meetings_members#export', as: 'meetings_export'

  get 'events_export', to: 'events_members#export', as: 'events_export'

  resources :speeches
  post '/read_and_convert', to: 'speeches#read_and_convert' 

  get '/check_member_attendance', to: 'members#check_member_attendance'

  
end
