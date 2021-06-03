class SavedDeals < ActiveRecord::Base
    belongs_to :users
    belongs_to :categories
    belongs_to :cities
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

    def self.delete_from_db(user, user_input)
        selected_user_deals = SavedDeals.select {|deal| deal.user_id == user.id}
        title_to_delete = selected_user_deals[user_input-1].title
        SavedDeals.where(title: title_to_delete).destroy_all
    end
end