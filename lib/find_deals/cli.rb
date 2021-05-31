#CLI Controller

class FindDeals::CLI
    attr_accessor :city_input, :category_input, :user_name

    def initialize 
        @user_name = ""
    end

    def call
        puts "--------------------------------------------------------------------"
        puts ""
        puts "Welcome to this amazing promo finder!"
        puts ""
        @city_input = ""
        @category_input = ""
        prompt_user_city
        goodbye
    end

    def prompt_user_city
        puts "--------------------------------------------------------------------"
        puts ""
        puts "Which city hoping to find deals in?"
        puts ""
        puts <<-DOC
            1. Sydney
            2. Melbourne
            3. Perth
            4. Brisbane
            5. Adelaide
            6. Gold Coast
            DOC
        get_city_input
        puts ""
    end

    def select_city_from_input(input)
        while input == 0 && input > FindDeals::Cities.all.size
            invalid_input
        end
        FindDeals::Cities.find(input).name ## Collects it from the database
    end

    def select_category_from_input(input)
        while input == 0 && input > FindDeals::Categories.all.size
            invalid_input
        end
        FindDeals::Categories.find(input).name
    end

    def get_city_input
        input = ""
        input = gets.strip
        @city_input = select_city_from_input(input)
        input != "quit" ? prompt_user_category : goodbye
    end

    def prompt_user_category
        puts "----------------------------------------------------------------"
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
        puts ""
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
            puts "----------------------------------------------------------------"
            puts ""
            puts "DEALS FOR THIS INPUT"
            puts ""
            FindDeals::Deal.all.each.with_index(1) do |deal, index|
                puts "#{index}." 
                puts deal.print
            end
            print_more_info
        end
    
        def print_more_info
            
            if FindDeals::Deal.all.length != 0
                puts "--------------------------------------------------------------------"
                puts ""
                puts "Please enter the number of the deal you'd like to see more about. Type in quit to exit"
                input = gets.strip
                puts ""
            else
                puts "Sorry! No deals for this section today. Please try another selection."
                puts ""
                puts "--------------------------------------------------------------------"
                prompt_user_city
            end
           
            
            number = input.to_i 
            if number != 0 && number <= FindDeals::Deal.all.size && input != "quit" ## to_i converts to 0 if not an integer
                FindDeals::Deal.all[number - 1].print_about_details
            elsif input == "quit"
                goodbye
                exit
            else 
                invalid_input
            end
<<<<<<< HEAD
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
=======
            save_deal(FindDeals::Deal.all[number - 1])
        end

        def save_deal(deal)
            input = ""
            puts ""
            puts "Would you like to save this deal? Y or N"
            input = gets.strip.downcase
            if input == "y"
                user = get_user
                puts "Saving deal..."
                puts ""
                puts "--------------------------------------------------------------------"
                deal.save(user.id) ##save to Saved Deals, with the user id as the User_id
                show_deals
                another_deal
            elsif input == "n"
                another_deal
            elsif input == "quit"
                goodbye
            else
                invalid_input
                save_deal(deal)
            end
        end

        def get_user
            puts "--------------------------------------------------------------------"
            puts ""
            puts "Please enter a username"
            @user_name = gets.strip.downcase
            puts ""
            puts "--------------------------------------------------------------------"
            Users.find_or_create_by(name: @user_name)
        end
    
    def show_deals
        input = ""
        puts "--------------------------------------------------------------------"
        puts ""
        puts "Would you like to see your saved deals? Y or N"
        input = gets.strip.downcase
        get_user

        if input == "y"
            puts ""
            puts "--------------------------------------------------------------------"
            show_saved_deals
        elsif input == "n"
            another_deal
        elsif input == "quit"
            goodbye
        else 
            invalid_input
            show_deals
        end

    end

    
    def show_saved_deals
        puts ""
        puts "--------------------------------------------------------------------"
        puts ""
        puts "YOUR SAVED DEALS"
        puts ""
        puts "--------------------------------------------------------------------"
        get_user.all.each.with_index(1) do |deal, index|
            puts "#{index}." 
            puts deal.print
        end
    end

    def another_deal
        input = ""
        puts "--------------------------------------------------------------------"
        puts ""
        puts "Would you like to check out another deal? Y or N"
        puts "To delete a saved deal type D"
        input = gets.strip.downcase

            if input == "y"
                puts ""
                puts "--------------------------------------------------------------------"
                @city_input = ""
                @category_input = ""
                prompt_user_city
            elsif input == "n" || input == "quit"
                goodbye
            elsif input == "d"
                delete_record
                another_deal
            else  
                invalid_input
                another_deal
            end
    end

    

    def delete_record 
        input = ""
        puts "--------------------------------------------------------------------"
        puts ""
        puts "Type in the number of the deal you would like to delete"
        input = gets.strip.downcase
        puts ""
        puts "--------------------------------------------------------------------" 
        
        if input.to_i != 0 && input.to_i <= SavedDeals.all.delete_from_db(input.to_i)
            show_deals
            another_deal
        else 
            puts "--------------------------------------------------------------------"
            puts ""
            puts "Invalid input. Please try again"
            puts ""
            puts "--------------------------------------------------------------------"
            delete_record
        end 
    end

    def invalid_input
        puts "--------------------------------------------------------------------"
        puts ""
        puts "Invalid input. Please try again"
        puts ""
        puts "--------------------------------------------------------------------"
    end

    def goodbye
        puts "--------------------------------------------------------------------"
>>>>>>> user-implementation
        puts ""
        puts "Hope to see you again soon for more deals!"
        puts ""
        puts "--------------------------------------------------------------------"
        exit
    end
end
