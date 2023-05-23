class CreateRwTimetables < ActiveRecord::Migration[6.1]
  def change
    create_table :rw_timetables do |t|
      t.integer :train_id
      t.integer :station_id
      t.datetime :time_arr
      t.datetime :time_dep

      t.timestamps
    end
  end
end
