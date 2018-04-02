class CreateWeatherStates < ActiveRecord::Migration[5.0]
  def change
    create_table :weather_states do |t|
      t.integer :weather_id
      t.string :main
      t.string :description
      t.string :icon

      t.timestamps
    end
  end
end
