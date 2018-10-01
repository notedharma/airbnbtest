class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.date :checkin
      t.date :checkout
      t.belongs_to :listing, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
