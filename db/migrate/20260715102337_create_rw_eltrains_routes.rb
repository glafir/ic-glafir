class CreateRwEltrainsRoutes < ActiveRecord::Migration[6.1]
  def change
    create_table :rw_eltrains_routes do |t|
      t.integer :station_id
      t.integer :priority_direct

      t.timestamps
    end
  end
end
