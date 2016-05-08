class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.references :user, index: true, foreign_key: true
      t.references :profile, index: true, foreign_key: true
      t.datetime :start_datetime
      t.datetime :end_datetime
      t.integer :performance_fee
      t.integer :total
      t.boolean :status

      t.timestamps null: false
    end
  end
end
