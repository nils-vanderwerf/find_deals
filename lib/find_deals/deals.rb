class FindDeals::Deal < ActiveRecord::Base
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
            puts "#{self.price} - #{self.promotion.upcase}"
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

    def self.reset_all
        @@all.clear
    end

end