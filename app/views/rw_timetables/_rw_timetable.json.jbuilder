json.extract! rw_timetable, :id, :train_id, :station_id, :time_arr, :time_dep, :created_at, :updated_at
json.url rw_timetable_url(rw_timetable, format: :json)
