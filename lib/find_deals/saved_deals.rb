class FindDeals::SavedDeals < ActiveRecord::Base
    def print
        puts "===================================================================="
            puts "#{self.title.upcase}"
            puts "#{self.location}"
            puts ""
            puts "#{self.about}"
            puts ""
            puts "$#{self.price.to_i} - UP TO #{self.promotion.to_i}% OFF"
        puts "===================================================================="
        puts "BUY NOW AT #{self.url}"
        puts "===================================================================="
    end
end