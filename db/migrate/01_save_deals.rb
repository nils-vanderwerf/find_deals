# db/migrate/01_create_artists.rb

class SaveDeals < ActiveRecord::Migration[5.2]

    def change
        create_table :saved_deals do |d|
            d.string :title
            d.string :url
            d.string :location
            d.float :price
            d.integer :promotion
            d.string :about
    end

    def self.up
        rename_table :deals, :saved_deals
      end
    
      def self.down
        rename_table :saved_deals, :deals
      end
end
end

