class RenameStationIdRwEltrainsRouteIdRwEltrainsTimetables < ActiveRecord::Migration[6.1]
  def change
        rename_column :rw_eltrains_timetables, :station_id, :rw_eltrains_route_id
  end
end
