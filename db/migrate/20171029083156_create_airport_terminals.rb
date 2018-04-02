class CreateAirportTerminals < ActiveRecord::Migration[5.0]
  def change
    create_table :airport_terminals do |t|
      t.integer :airport_id
      t.string :terminal

      t.timestamps
    end
  end
end
