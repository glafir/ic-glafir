class AddNumberToRwEltrainsRoutes < ActiveRecord::Migration[6.1]
  def change
    add_column :rw_eltrains_routes, :number, :integer
  end
end
