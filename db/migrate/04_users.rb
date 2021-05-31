# db/migrate/01_create_artists.rb

class Users < ActiveRecord::Migration[5.2]

    def change
        create_table :users do |u|
            u.string :name
    end
end
end

