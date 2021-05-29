# db/migrate/01_create_artists.rb

class CreateDeals < ActiveRecord::Migration[5.2]

    def change
        create_table :deals do |d|
            d.string :title
            d.string :url
            d.string :location
            d.float :price
            d.integer :promotion
            d.string :about
    end
end
end

