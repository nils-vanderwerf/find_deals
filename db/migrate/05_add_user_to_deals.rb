# db/migrate/01_create_artists.rb

class AddUserToDeals < ActiveRecord::Migration[5.2]

    def change
        add_column :saved_deals, :user_id, :integer
    end
end
