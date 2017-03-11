class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :lang
      t.string :lang_iso
      t.string :lang_iata

      t.timestamps null: false
    end
  end
end
