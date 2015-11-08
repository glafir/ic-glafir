class AddAvatarToAircompanies < ActiveRecord::Migration
  def change
    add_column :aircompanies, :avatar, :string
  end
end
