class AddEltrainNumberToRwEltrainsTimetables < ActiveRecord::Migration[6.1]
  def change
    add_column :rw_eltrains_timetables, :eltrains_number, :integer
  end
end
