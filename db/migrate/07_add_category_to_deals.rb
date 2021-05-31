class AddCategoryToDeals < ActiveRecord::Migration[5.2]

    def change
        add_column :saved_deals, :category_id, :integer
    end
end