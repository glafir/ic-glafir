class CreateStationZones < ActiveRecord::Migration
  def change
    create_table :station_zones do |t|
      t.string :station_id
      t.string :zone

      t.timestamps null: false
    end
  end
end
