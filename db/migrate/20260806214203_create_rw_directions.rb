class CreateRwDirections < ActiveRecord::Migration[6.1]
  def change
    create_table :rw_directions do |t|
      t.integer :station_id
      t.integer :direction_station_id

      t.timestamps
    end
  end
end
