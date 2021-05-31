# db/migrate/01_create_artists.rb

class SaveDeals < ActiveRecord::Migration[5.2]

    def change
        create_table :saved_deals do |d|
            d.string :title
            d.string :url
            d.string :location
            d.integer :price
            d.integer :promotion
            d.string :about
            d.integer :user_id
            d.integer :category_id
            d.integer :city_id
    end

    def self.up
        rename_table :deals, :saved_deals
      end
    
      def self.down
        rename_table :saved_deals, :deals
      end
end
end

