class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
