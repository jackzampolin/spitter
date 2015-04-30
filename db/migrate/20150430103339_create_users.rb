class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password
      t.string :first_name
      t.string :last_name
      t.string :about_me
      t.string :picture_url

      t.timestamps
    end
  end
end
