class FindDeals::Users < ActiveRecord::Base
    has_many :saved_deals

    # attr_reader :name

    # # @@all = []
    # # def initialize(name)
    # #     @name = name
    # #     @@all << self
    # # end

    # # def add_user_to_db
    
    # # end

    
end