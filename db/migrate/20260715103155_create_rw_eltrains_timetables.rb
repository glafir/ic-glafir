class CreateRwEltrainsTimetables < ActiveRecord::Migration[6.1]
  def change
    create_table :rw_eltrains_timetables do |t|
      t.integer :station_id
      t.integer :direction
      t.time :time_start
      t.time :time_finish
      t.integer :w1
      t.integer :w2
      t.integer :w3
      t.integer :w4
      t.integer :w5
      t.integer :w6
      t.integer :w0

      t.timestamps
    end
  end
end
