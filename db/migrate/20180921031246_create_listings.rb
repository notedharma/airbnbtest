class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.string :title
      t.text :description
      t.string :address
      t.string :city
      t.string :country
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
