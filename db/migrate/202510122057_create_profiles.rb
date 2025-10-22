class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.integer :user_id, null: false
      t.index :user_id, unique: true
      t.string :display_name
      t.text :bio
      
      t.timestamps
    end
  end
end
