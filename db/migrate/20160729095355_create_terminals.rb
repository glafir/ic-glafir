class CreateTerminals < ActiveRecord::Migration
  def change
    create_table :terminals do |t|
      t.string :name
      t.string :marking
      t.integer :floor
      t.integer :reception
      t.integer :parking
      t.integer :teletrap
      t.integer :gate
      t.integer :airport_id
      t.float :area

      t.timestamps null: false
    end
  end
end
