#CLI Controller

class FindDeals::CLI
    attr_accessor :city_input, :category_input
    CITIES = {
        "1" => "sydney",
        "2" => "melbourne",
        "3" => "perth",
        "4" => "brisbane",
        "5" => "adelaide",
        "6" => "gold-coast"
    }
    CATEGORIES = {
        "1" => nil,
        "2" => "dining",
        "3" => "wellness-beauty",
        "4" => "activities",
        "5" => "shopping",
        "6" => "services",
        "7" => "wine",
        "8" => "personalised-gifts"
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
        @city_input = select_city_from_input(input)
        puts @city_input
        show_option_to_quit
        if input != "quit"
            prompt_user_category
        end
    end

    def prompt_user_category
        puts ""
        puts "Which category are you hoping to find deals in ?"
        puts "Type quit to exit the program"
        puts <<-DOC
        1. Anything
        2. Dining
        3. Wellness & Beauty
        4. Activities
        5. Shopping
        6. Services
        7. Wine
        8. Personalised Gifts
        DOC
        get_category_input
    end

    def get_category_input
        input = ""
        input = gets.strip
        @category_input = select_category_from_input(input)
        site_scraper = FindDeals::Scraper.new(@city_input, @category_input)
        print_deals(@city_input, @category_input)
    end

        def print_deals(city, category)
            "Here are some great deals:"
            FindDeals::Deal.all.each.with_index(1) do |deal, index|
                puts "#{index}." 
                puts deal.print
            end
            print_more_info
        end
    
        def print_more_info
            if FindDeals::Deal.all.length != 0
                puts "Please enter the number of the deal you'd like to see more about. Type in quit to exit"
            else
                puts "Sorry! No deals for this section. Please try another selection."
                puts ""
                puts "===================================================================="
                puts ""
                prompt_user_city
            end
           
            input = ""
            input = gets.strip
            number = input.to_i 
            if number != 0 && number <= FindDeals::Deal.all.size && input != "quit" ## to_i converts to 0 if not an integer
                FindDeals::Deal.all[number - 1].print_about_details
            elsif input == "quit"
                exit
            else 
                puts "Invalid input. Please try again"
            end
            save_deal
        end

        def save_deal
            puts "Would you like to save this deal. Y or N"
            input = ""
            input = gets.strip.downcase
            while input != "y" || input != "n" || input != "quit"
            if input == "y"
                puts "Saving deal..."
                ##save to database
                puts "Would you like to see your saved deals?"
                ##show saved deals
            elsif input == "n"
                another_deal
            else
                puts "Invalid input. Please try again"
            end 
            end
        end

    def another_deal
        puts "Would you like to check out another deal? Y or N"
        input = ""
        input = gets.strip.downcase
        while input != "y" || input != "n" || input != "quit"
            if input == "y"
                @city_input = ""
                @category_input = ""
                prompt_user_city
            elsif input == "n"
                exit
            else
                puts "Invalid input. Please try again"
            end 
        end
    end
    def show_option_to_quit
        puts ""
        puts "===================================================================="
        puts "type 'quit' at any time to quit"
        puts "===================================================================="
        puts ""
    end
end
