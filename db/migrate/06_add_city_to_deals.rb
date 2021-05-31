class AddCityToDeals < ActiveRecord::Migration[5.2]

    def change
        add_column :saved_deals, :city_id, :integer
    end
end