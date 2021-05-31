class Users < ActiveRecord::Base
    has_many :saved_deals

end