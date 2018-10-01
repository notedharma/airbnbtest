class AddToUsersListings < ActiveRecord::Migration[5.2]
  def change

      add_column :users, :phone, :string
      add_column :users, :country, :string

    
      add_column :listings, :property_type, :string
      add_column :listings, :beds, :integer
      add_column :listings, :max_guests, :integer
      add_column :listings, :price_night, :integer



  

    end
  
end
