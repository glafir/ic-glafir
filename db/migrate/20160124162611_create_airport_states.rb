class CreateAirportStates < ActiveRecord::Migration
  def change
    create_table :airport_states do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
