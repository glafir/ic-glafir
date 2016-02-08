class CreateAirportAirTraffics < ActiveRecord::Migration
  def change
    create_table :airport_air_traffics do |t|
      t.string :name
      t.integer :klass

      t.timestamps null: false
    end
  end
end
