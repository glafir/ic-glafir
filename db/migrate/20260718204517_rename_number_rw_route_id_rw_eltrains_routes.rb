class RenameNumberRwRouteIdRwEltrainsRoutes < ActiveRecord::Migration[6.1]
  def change
    rename_column :rw_eltrains_routes, :number, :rw_route_id
  end
end
