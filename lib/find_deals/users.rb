class FindDeals::Users < ActiveRecord::Base
    has_many :deals
end