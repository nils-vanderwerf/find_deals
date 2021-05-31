class FindDeals::Categories < ActiveRecord::Base
    has_many :saved_deals
end
