class CreateTrains < ActiveRecord::Migration[6.1]
  def change
    create_table :trains do |t|
      t.integer :station_start
      t.integer :station_finish
      t.integer :train_number

      t.timestamps
    end
  end
end
