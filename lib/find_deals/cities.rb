class FindDeals::Cities < ActiveRecord::Base
    has_many :saved_deals
end