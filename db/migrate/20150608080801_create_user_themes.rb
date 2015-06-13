class CreateUserThemes < ActiveRecord::Migration
  def change
    create_table :user_themes do |t|
      t.string :theme

      t.timestamps
    end
  end
end
