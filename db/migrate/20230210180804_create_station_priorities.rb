class CreateStationPriorities < ActiveRecord::Migration[6.1]
  def change
    create_table :station_priorities do |t|
      t.integer :station_id
      t.integer :rw_route_id
      t.integer :priority

      t.timestamps
    end
  end
end
