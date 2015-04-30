class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :photo_url, default:"http://i.imgur.com/AMhLg7v.jpg"
      t.string :encrypted_password
      t.string :bio

      t.timestamps
    end
  end
end