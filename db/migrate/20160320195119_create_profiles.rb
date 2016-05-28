class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :category
      t.integer :member
      t.string :profile_name
      t.text :bio
      t.string :location
      t.boolean :is_english
      t.boolean :is_indonesia
      t.boolean :is_travel
      t.boolean :is_wedding
      t.boolean :is_corporate
      t.boolean :is_private
      t.boolean :is_birthday
      t.boolean :is_school
      t.boolean :is_cafe
      t.integer :performance_fee
      t.string :fee_unit
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
