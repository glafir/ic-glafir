class DeviseCreateSignInFailures < ActiveRecord::Migration
  def change
    create_table(:sign_in_failures) do |t|

      t.string :email
      t.string :ip_address
      t.string :user_agent

      t.timestamps null: false
    end
  end
end
