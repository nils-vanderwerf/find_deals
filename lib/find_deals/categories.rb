class FindDeals::Categories < ActiveRecord::Base
    has_many :deals
end