class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.string :name_rus
      t.string :name_eng
      t.string :zone_station_id

      t.timestamps null: false
    end
  end
end
