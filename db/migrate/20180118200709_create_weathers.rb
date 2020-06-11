class CreateWeathers < ActiveRecord::Migration[5.0]
  def change
    create_table :weathers do |t|
      t.integer :place_id
      t.float :temp
      t.float :temp_min
      t.float :temp_max
      t.float :pressure
      t.float :pressure_sea_level
      t.float :pressure_grnd_level
      t.float :wind_speed
      t.float :wind_deg
      t.integer :clouds
      t.integer :dt

      t.timestamps
    end
  end
end
