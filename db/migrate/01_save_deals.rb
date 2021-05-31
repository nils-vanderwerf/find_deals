class SaveDeals < ActiveRecord::Migration[5.2]

    def change
        create_table :saved_deals do |d|
            d.string :title
            d.string :url
            d.string :location
            d.integer :price
            d.integer :promotion
            d.string :about
        end
        add_foreign_key :saved_deals, :users
        add_foreign_key :saved_deals, :categories
        add_foreign_key :saved_deals, :cities
    end
end

