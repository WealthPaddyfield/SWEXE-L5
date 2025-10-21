class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true, index: { unique: true } # 1:1
      t.string :display_name
      t.text :bio
      t.string :avatar_url
      t.string :website
      t.timestamps
    end
  end
end
