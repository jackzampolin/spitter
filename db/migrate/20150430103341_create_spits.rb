class CreateSpits < ActiveRecord::Migration
  def change
    create_table :spits do |t|
      t.string :content
      t.references :user

      t.timestamps
    end
  end
end
