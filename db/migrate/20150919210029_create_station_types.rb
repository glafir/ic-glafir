class CreateStationTypes < ActiveRecord::Migration
  def change
    create_table :station_types do |t|
      t.string :typename

      t.timestamps null: false
    end
  end
end
