class FindDeals::Deal 
    attr_accessor :title, :location, :url, :price, :promotion, :about

    @@all = []

    def initialize (title: nil, url: nil, location: nil, price: "$0", promotion: "0%", about: nil)
        @@all << self
        @title = title
        @location = location
        @url = url
        @price = price
        @promotion = promotion 
        @about = about
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
        puts "===================================================================="
        puts "BUY NOW AT #{self.url}"
        puts "===================================================================="
    end

    def save
        # FindDeals::SavedDeals.connection
        FindDeals::SavedDeals.find_or_create_by(title: self.title, location: self.location, url: self.url, price: self.price, promotion: self.promotion, about: self.about)
    end

    def print_all_from_db

    end        
    

    def self.reset_all
        @@all.clear
    end

end