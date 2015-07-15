IcApp::Application.routes.draw do
  resources :flash_message_states
  netzke "/netzke", controller: :admin
  resources :user_tracings
  resources :flash_messages
  get "errors/error_404", :as => "error404"
  get "errors/error_403", :as => "error403"
  resources :roles
  resources :user_themes
  resources :aphubs
  get '/timecor' => "general#timecor"
  get '/apcor' => "general#apcor"
  resources :regions
  resources :towns do
    get :autocomplete_town_accent_city, :on => :collection
    collection do
      get "admin_tw"
      get "tw_dist"
    end
  end

  get "/ap_to_tw" => "towns#apToTw"
  resources :flight_types
  resources :aircraft_companies
  resources :aircraft_wake_categories
  resources :aircraft_types
  resources :aircrafts do
    get :autocomplete_aircraft_aircraft_model, :on => :collection
    collection do
    end
  end
  resources :countries do
    member do
      get 'ap_show'
      get 'tw_show'
      get 'al_show'
    end
    collection do
    end
  end
  resources :runway_aps
  get "/runway_aps/:id/calendar/" => "runway_aps#runway_calendar"
  get "/runway_aps/:id/:date" => "runway_aps#rasp_runway_day"
  resources :timetablesap_flights
  get "/timetablesap_flight/form" => "timetablesap_flights#form"
  get "/some" => "timetablesap_flights#some"
  post "/timetablesap_flight/form" => "timetablesap_flights#form_enter"
  resources :rw_typestations
  resources :rw_routes
  resources :rw_stations
  devise_for :users, :controllers => {
    :sessions => 'users/sessions',
    :registrations => "users/registrations"
  }

  devise_scope :user do
    root :to => 'users/sessions#new'
    get "sign_in", :to => "users/sessions#new"
    get "users/sign_out", :to => "users/sessions#destroy"
    delete "users/sign_out", :to => "users/sessions#destroy"
  end
  resources :users
  resources :zones_stations
  resources :regions
  resources :timetableaps do
    collection do
      get 'ttair_admin'
    end
    member do
      get "update_dateoffinishdate"
      get "flight_state"
    end
  end
  resources :timetableap_subs do
    member do
      get "flight_state" 
    end
  end
  post "/timetableaps/new" => "timetableaps#new"
  resources :aircompanies do
    get :autocomplete_aircompany_airline_name_rus, :on => :collection
    collection do
      get "admin_al"
    end
  end
  resources :airports do
    get :autocomplete_airport_name_rus, :on => :collection
    collection do
      get "admin_ap"
      get "ap_dist"
    end
    member do
      get "tablo" => "airports#tablo"
      get "tablo/:apt" => "airports#tablo"
      get "tt"
      get "aptt"
      get "city"
      get "city/:city_eng" => "airports#city"
    end
  end

#  post "/airports/:id/tablo_in"
  get "/search/airlines" => "airports#search_airlines"
  get "/search" => "airports#search"
  post "/search" => "airports#search"
  get "general/rw"
  get "general/timenow"
  get "general/air"
  get "general/help"  
  get "general/home"
  get "/general" => "general#home"
  get "insertdata" => "timetableaps#insert"
  get "chnglocale" => "general#chnglocale"
#  get "/*other" => redirect("/errors/error_404")
end
