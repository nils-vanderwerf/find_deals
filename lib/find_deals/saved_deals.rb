class SavedDeals < ActiveRecord::Base
    def print
        puts "===================================================================="
            puts "#{self.title.upcase}"
            puts "#{self.location}"
            puts ""
            puts "#{self.about}"
            puts ""
            puts "$#{self.price.to_i} - UP TO #{self.promotion.to_i}% OFF"
            puts ""
            puts "BUY NOW AT #{self.url}"
        puts "===================================================================="
    end

    def self.delete_from_db(user_input)
        title_to_delete = self.all[user_input-1].title
        self.where(title: title_to_delete).destroy_all
    end
end