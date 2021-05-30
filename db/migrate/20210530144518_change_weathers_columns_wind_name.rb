class ChangeWeathersColumnsWindName < ActiveRecord::Migration[5.2]
  def change
    rename_column :weathers, :wind_deg, :wind_angle
  end
end
