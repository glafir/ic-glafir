json.extract! train, :id, :station_start, :station_finish, :train_number, :created_at, :updated_at
json.url train_url(train, format: :json)
