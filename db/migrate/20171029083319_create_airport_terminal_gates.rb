class CreateAirportTerminalGates < ActiveRecord::Migration[5.0]
  def change
    create_table :airport_terminal_gates do |t|
      t.integer :airport_terminal_id
      t.string :gate

      t.timestamps
    end
  end
end
