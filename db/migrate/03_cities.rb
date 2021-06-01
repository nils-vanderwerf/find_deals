class Cities < ActiveRecord::Migration[5.2]
    def change
        create_table :cities do |c|
            c.string :name
        end
    end
    
end