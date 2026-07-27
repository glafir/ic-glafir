class AddStationIdToRwEltrainsTimetables < ActiveRecord::Migration[6.1]
  def change
    add_column :rw_eltrains_timetables, :station_id, :integer
  end
end
