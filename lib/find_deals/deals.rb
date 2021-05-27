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

    def self.print
        puts "=================================="
            puts self.title.upcase
            puts self.location
            puts self.price
            puts self.promotion
            puts "BUY NOW"
            puts self.url
        puts "=================================="
    end

    def self.reset_all
        @@all.clear
    end

end