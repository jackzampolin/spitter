class CreateSpits < ActiveRecord::Migration
  def change
    create_table :spits do |t|
      t.string :content
      t.references :user
      t.integer :favorite_count, default: 0

      t.timestamps
    end
  end
end
