class Categories < ActiveRecord::Migration[5.2]
    def change
        create_table :categories do |c|
            c.string :name
        end
    end

    # FindDeals::Cities.create(name: nil)
    # FindDeals::Cities.create(name: "dining")
    # FindDeals::Cities.create(name: "wellness-beauty")
    # FindDeals::Cities.create(name: "activities")
    # FindDeals::Cities.create(name: "shopping")
    # FindDeals::Cities.create(name: "services")
    # FindDeals::Cities.create(name: "wine")
    # FindDeals::Cities.create(name: "personalised-gifts")
end