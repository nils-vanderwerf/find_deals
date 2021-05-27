#CLI Controller

class FindDeals::CLI
    attr_accessor :all_input
    CITIES = {
        "1" => "sydney",
        "2" => "melbourne",
        "3" => "perth",
        "4" => "brisbane",
        "5" => "adelaide",
        "6" => "gold-coast"
    }
    CATEGORIES = {
        "1" => "anything",
        "2" => "dining",
        "3" => "wellness-beauty",
        "4" => "activities",
        "5" => "travel",
        "6" => "shopping",
        "7" => "services",
        "8" => "wine",
        "9" => "personalised-gifts"
    }

    def call
       
        puts "Welcome to this amazing promo finder!"
        @city_input = ""
        @category_input = ""
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

    def select_city_from_input(input)
        CITIES[input.to_s]
    end
    
    def select_category_from_input(input)
         CATEGORIES[input.to_s]
    end

    def get_city_input
        input = ""
        input = gets.strip
        show_option_to_quit
        if input != "|quit|"
            prompt_user_category
        end
        @city_input = select_city_from_input(input)
        @city_input
    end

    def prompt_user_category
        puts ""
        puts "Which category are you hoping to find deals in ?"
        puts "Type |quit| to quit the program"
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
        input = ""
        while input != "|quit"
            input = gets.strip
            @category_input = select_category_from_input(input)

            site_scraper = FindDeals::Scraper.new(select_city_from_input(@city_input), select_category_from_input(@category_input))
        end
        print_deals
    end

        def print_deals
            FindDeals::Deal.print
        end

    def show_option_to_quit
        puts ""
        puts "--------------------------------"
        puts "type |quit| at any time to quit"
        puts "--------------------------------"
        puts ""
    end
end