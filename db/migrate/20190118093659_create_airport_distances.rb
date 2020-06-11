class CreateAirportDistances < ActiveRecord::Migration[5.0]
  def change
    create_table :airport_distances do |t|
      t.integer :airport_start_id
      t.integer :airport_finish_id
      t.float :distance

      t.timestamps
    end
  end
end
