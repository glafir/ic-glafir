IcApp::Application.routes.draw do
  root :to => 'general#home'

  resources :aphubs
  netzke
  get '/timecor' => "general#timecor"
  resources :regions
  resources :towns
  get "/ap_to_tw" => "towns#apToTw"
  resources :flight_types
  resources :aircraft_companies
  resources :aircraft_wake_categories
  resources :aircraft_types
  resources :aircrafts
  resources :countries do
    member do
      get 'ap_show'
      get 'tw_show'
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
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  devise_scope :user do
    get "sign_in", :to => "devise/sessions#new"
    get "/logout", :to => "devise/sessions#destroy"
    delete "/logout", :to => "devise/sessions#destroy"
  end
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
end
