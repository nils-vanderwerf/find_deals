#CLI Controller

class FindDeals::CLI
    attr_accessor :city_input, :category_input, :deals
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

    def initialize 
        @deals = FindDeals::SavedDeals.all
    end

    def call
        puts "Welcome to this amazing promo finder!"
        @city_input = ""
        @category_input = ""
        prompt_user_city
        goodbye
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
        show_option_to_quit
        input != "quit" ? prompt_user_category : goodbye
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
        if input != 'quit'
            @category_input = select_category_from_input(input)
            site_scraper = FindDeals::Scraper.new(@city_input, @category_input)
            print_deals(@city_input, @category_input)
        end
    end

        def print_deals(city, category)
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
           
            input = gets.strip
            number = input.to_i 
            if number != 0 && number <= FindDeals::Deal.all.size && input != "quit" ## to_i converts to 0 if not an integer
                FindDeals::Deal.all[number - 1].print_about_details
            elsif input == "quit"
                goodbye
                exit
            else 
                puts "Invalid input. Please try again"
            end
            save_deal(FindDeals::Deal.all[number - 1])
        end

        def save_deal(deal)
            input = ""
            puts "Would you like to save this deal? Y or N"
            input = gets.strip.downcase
            if input == "y"
                puts "Saving deal..."
                deal.save
                show_deals
                another_deal
            elsif input == "n"
                another_deal
            elsif input == "quit"
                goodbye
            else
                puts "Invalid input. Please try again"
                save_deal(deal)
            end
        end


    def show_deals
        input = ""
        puts "Would you like to see your saved deals? Y or N"
        input = gets.strip.downcase

        if input == "y"
            @deals.all.each.with_index(1) do |deal, index|
                puts "#{index}." 
                puts deal.print
            end
        elsif input == "n"
            another_deal
        elsif input == "quit"
            goodbye
        else 
            puts "Invalid input. Please try again"
        end

    end

    def another_deal
        puts "===================================================================="
        puts ""
        input = ""
        puts "Would you like to check out another deal? Y or N"
        puts "To delete a saved deal type D"
        input = gets.strip.downcase

            if input == "y"
                @city_input = ""
                @category_input = ""
                prompt_user_city
            elsif input == "n" || input == "quit"
                goodbye
            elsif input == "d"
                delete_record
                another_deal
            else  
                puts "Invalid input. Please try again"
            end

    end

    def delete_record 
        puts "===================================================================="
        puts ""
        input = ""
        puts "Type in the number of the deal you would like to delete" 
        input = gets.strip.downcase
        
        if input.to_i != 0 && input.to_i <= FindDeals::SavedDeals.all.size
            FindDeals::SavedDeals.all.delete_from_db(input.to_i)
            show_deals
            another_deal
        else 
            puts "Invalid input. Please try again"
        end 
    end

    def show_option_to_quit
        puts ""
        puts "===================================================================="
        puts "type 'quit' at any time to quit"
        puts "===================================================================="
        puts ""
    end

    def goodbye
        puts "Okay. Hoping to see you again soon for more deals!"
        puts "===================================================================="
        exit
    end
end
