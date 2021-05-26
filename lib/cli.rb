#CLI Controller
require_relative '../config/environment'
require_relative './scraper'

class FindDeals::CLI
    attr_accessor :all_input

    def call
        puts "Welcome to this amazing promo finder!"
        @all_input = []
        prompt_user_city
    end

    def prompt_user_city
        puts "Which city hoping to find deals in ?"
        puts <<-DOC
            1. Sydney
            2. Melbourne
            3. Perth
            4. Brisbane
            5. Adelaide
            6. Gold Coast
            7. Other?
            DOC
        get_city_input
    end
    
    def get_city_input
        input = gets.strip.downcase
            
        case input
            when "1"
                all_input[0] = "sydney"
            when "2"
                all_input[0] = "melbourne"
            when "3"
                all_input[0] = "perth"
            when "4"
                all_input[0] = "brisbane"
            when "5"
                all_input[0] = "adelaide"
            when "6", "gold coast"
                all_input[0] = "gold-coast"
            when "7", 'other'
                puts "Please enter your post code" 
            when "sydney", 'melbourne', 'perth', 'brisbane' 'gold-coast', 'adelaide'
                all_input[0] = input
            else
                puts "Sorry, we don't recognise that input"
            end
        
        puts "Input: #{@all_input}"
        prompt_user_category
    end

    def prompt_user_category
        puts ""
        puts "Which category are you hoping to find deals in ?"
        puts <<-DOC
        1. Anything
        2. Dining
        3. Wellness & Beauty
        4. Activities
        5. Travel
        6. Shopping
        7. Services
        8. Wine
        9. Personalised Gifts
        DOC
        get_category_input
    end

    def get_category_input
        input = nil
        input = gets.strip.downcase
            case input
                when "1", "anything"
                all_input[1] = ""
                puts "Here are some great deals:"
                when "2"
                    all_input[1] = "dining"
                    puts "Here are some great dining deals:"
                when "3", "wellness and beauty"
                    all_input[1] = "wellness-beauty"
                    puts "Here are some great wellness & beauty deals:"
                when "4"
                    all_input[1] = "activities"
                    puts "Here are some great deals on activities:"
                when "5"
                    all_input[1] = "travel"
                    puts "Here are some great travel deals:"
                when "6",
                    all_input[1] = "shopping" 
                    puts "Here are some great shopping deals:"
                    ##Deals
                    ##Redirect to the link
                when "7"
                    all_input[1] = "services" 
                    puts "Here are some great services deals:"
                when "8"
                    all_input[1] = "wine" 
                    puts "Here are some great wine deals:"
                when "9", "personalised gifts"
                    all_input[1] = "personalised-gifts" 
                    puts "Here are some great personalised gifts deals:"
                when "dining", 'wellness & beauty', 'activities', 'travel' 'shopping', 'services', "wine", "personalised-gifts"
                    all_input[1] = input
                else
                    puts "Sorry, we don't recognise that input"
            end
        puts "Category Input: #{@all_input}"
        Scraper.get_page(all_input)

    end
end