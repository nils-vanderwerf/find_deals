#CLI Controller
require './config/environment.rb'

class FindDeals::CLI
    def call
        puts "Welcome to this amazing promo finder!"
        
    end

    def start
        puts ""
        puts "Which city are you hoping to find deals in ?"
    end
end