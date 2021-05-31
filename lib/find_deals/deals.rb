class FindDeals::Deal 
    attr_accessor :title, :location, :url, :price, :promotion, :about, :city_id, :category_id

    @@all = []

    def initialize (title: nil, url: nil, location: nil, price: 0, promotion: 0, about: nil, category_id: 1, city_id: 1)
        @@all << self
        @title = title
        @location = location
        @url = url
        @price = price
        @promotion = promotion 
        @about = about
        @category_id = category_id
        @city_id = city_id
    end

    def self.all
        @@all
    end

    def print
        puts "===================================================================="
            puts "#{self.title.upcase}"
            puts "#{self.location}"
            puts "$#{self.price.to_i} - UP TO #{self.promotion.to_i}% OFF"
        puts "===================================================================="
    end

    def print_about_details
        puts "===================================================================="
        puts "#{self.title.upcase}"
        puts "===================================================================="
        puts "#{self.about}"
        puts ""
        puts "BUY NOW AT #{self.url}"
        puts "===================================================================="
    end

    def save(user_id)
        # FindDeals::SavedDeals.connection

        SavedDeals.find_or_create_by(
            title: self.title, 
            location: self.location, 
            url: self.url, 
            price: self.price, 
            promotion: self.promotion, 
            about: self.about, 
            category_id: self.category_id, 
            city_id: self.city_id,
            user_id: user_id
        )
    end

    def self.reset_all
        @@all.clear
    end

end