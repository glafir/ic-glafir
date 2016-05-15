IcApp::Application.routes.draw do
  concern :paginatable do
    get '(page/:page)', :action => :index, :on => :collection, :as => ''
  end
  resources :airport_air_traffics
  resources :airport_states
  resources :station_zones

  resources :stations do
    collection do
      get "admin_stations"
    end
  end

  resources :station_types
  resources :flash_message_states
  netzke "/netzke", controller: :admin
  get '/search_tt' => "timetableaps#search_tt", :as => "search_tt"
  resources :user_tracings, :concerns => :paginatable
  resources :flash_messages, :concerns => :paginatable
  get "errors/error_404", :as => "error404"
  get "errors/error_403", :as => "error403"
  resources :roles
  resources :user_themes
  resources :aphubs
  get '/timecor' => "general#timecor"
  get '/apcor' => "general#apcor"
  resources :regions
  resources :towns, :concerns => :paginatable do
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
  resources :countries, :concerns => :paginatable do
    resources :towns, :concerns => :paginatable do
      get :autocomplete_town_accent_city, :on => :collection
    end
    member do
      get 'ap_show'
      get 'ap_show_ajax'
      post 'ap_show_ajax'
      get 'tw_show'
      get 'al_show'
      get 'al_show/page/:page', :action => :al_show
      get 'ap_show/page/:page', :action => :ap_show
      get 'tw_show/page/:page', :action => :ap_show
      get 'page/:page', :action => :show
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
    :sessions => "users/sessions",
    :registrations => "users/registrations"
  }
  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "users/sign_out", :to => "users/sessions#destroy"
    delete "users/sign_out", :to => "users/sessions#destroy"
    root "users/sessions#new"
  end
  scope "/admin" do
    resources :users
  end
  resources :zones_stations
  resources :regions
  resources :timetableaps, :concerns => :paginatable do
    collection do
      get 'admin_tt'
    end
    member do
      get "update_dateoffinishdate"
      get "flight_state"
    end
  end
  resources :timetableap_subs, :concerns => :paginatable do
    member do
      get "flight_state" 
    end
  end
  post "/timetableaps/new" => "timetableaps#new"
  resources :aircompanies, :concerns => :paginatable do
    get :autocomplete_aircompany_airline_name_rus, :on => :collection
    collection do
      get "admin_al"
    end
    member do
      get 'flights/page/:page', :action => :show
    end
  end
  resources :airports, :concerns => :paginatable do
    get :autocomplete_airport_city_rus, :on => :collection
    collection do
      get "admin_ap"
      get "ap_dist"
      get "search_ap_circle"
      get "ap_maps"
    end
    member do
      get "tablo" => "airports#tablo"
      get "tablo/:apt" => "airports#tablo"
      get "tt"
      get "aptt"
      get "apload" => "airports#apload"
      get "apload/:apload" => "airports#apload"
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
