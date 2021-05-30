class ChangeWeathersColumnsName < ActiveRecord::Migration[5.2]
  def change
    rename_column :weathers, :temp, :temperature
    rename_column :weathers, :temp_min, :min_temperature
    rename_column :weathers, :temp_max, :max_temperature
  end
end
