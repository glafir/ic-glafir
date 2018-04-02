class CreateAirlineCodeshares < ActiveRecord::Migration
  def change
    create_table :airline_codeshares do |t|
      t.integer :aircompany_id
      t.integer :codeshare_id
      t.date :code_share_start
      t.date :code_share_finish

      t.timestamps null: false
    end
  end
end
