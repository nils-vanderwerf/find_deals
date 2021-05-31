class FindDeals::Cities < ActiveRecord::Base
    has_many :deals
end