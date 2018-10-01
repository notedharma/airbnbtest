class AddPriceAddNullsToReservations < ActiveRecord::Migration[5.2]
  def change
    add_column :reservations, :price, :integer

    change_column :reservations, :checkin, :date, null: false
    change_column :reservations, :checkout, :date, null: false
  end
end
