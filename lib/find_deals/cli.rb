class FindDeals::CLI
    attr_accessor :city_input, :category_input, :input, :user_name, :selected_deal

    def initialize 
        # @deals = FindDeals::SavedDeals.all
        @user_name = ""
        @input = ""
        @city_input = ""
        @category_input = ""
        @selected_deal
    end

    def call
        puts "--------------------------------------------------------------------"
        puts ""
        puts "Welcome to this amazing promo finder!"
        puts ""
        while @input != "quit"
            #-----LIST OF METHODS---#
            prompt_user_city
            get_city_input
            prompt_user_category
            get_category_input
            print_deals
            print_more_info
            prompt_to_save_deal
            prompt_to_show_saved_deals
            select_another_deal
        end
        goodbye #quit program
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
        
        puts ""
    end

    def get_city_input
        @input = gets.strip
        @city_input = select_city_from_input(@input)
    end

    def select_city_from_input(input)
        while input.to_s == 0 && input > Cities.all.size
            invalid_input
        end
        Cities.find(input).name ## Collects it from the database
    end

    def select_category_from_input(input)
        while input.to_s == 0 && input > Categories.all.size
            invalid_input
        end
       Categories.find(input).name
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
        puts ""
    end

    def get_category_input
        @input = gets.strip
        @category_input = select_category_from_input(input)
        site_scraper = FindDeals::Scraper.new(@city_input, @category_input)
    end

        def print_deals
            puts "----------------------------------------------------------------"
            puts ""
            puts "DEALS FOR THIS INPUT"
            puts ""
            FindDeals::Deal.all.each.with_index(1) do |deal, index|
                puts "#{index}." 
                puts deal.print
            end
        end
    
        def print_more_info
            
            if FindDeals::Deal.all.length != 0
                puts "--------------------------------------------------------------------"
                puts ""
                puts "Please enter the number of the deal you'd like to see more about. Type in quit to exit"
                

                puts ""
                while input.to_s == 0
                    @input = gets.strip
                    invalid_input
                end
            else
                puts "Sorry! No deals for this section today. Please try another selection."
                puts ""
                puts "--------------------------------------------------------------------"
                prompt_user_city
            end
           
            
            number = @input.to_i 
            if number != 0 && number <= FindDeals::Deal.all.size && input != "quit" ## to_i converts to 0 if not an integer
                FindDeals::Deal.all[number - 1].print_about_details
            else 
                invalid_input
            end
            @selected_deal = FindDeals::Deal.all[number - 1]
        end

        def prompt_to_save_deal
            puts ""
            puts "Would you like to save this deal? Y or N"
            @input = gets.strip.downcase
            if @input == "y"
                user = get_user
                puts "Saving deal..."
                puts ""
                puts "--------------------------------------------------------------------"
                
                @selected_deal.save(user.id) ##save to Saved Deals, with the user id as the User_id
            elsif @input == "n"
                
            else
                invalid_input
                prompt_to_save_deal
            end
        end

    def get_user
        puts "--------------------------------------------------------------------"
        puts ""
        puts "We need to be able to associate this deal with you."
        puts "Please enter a username"
        @user_name = gets.strip
        puts ""
        puts "--------------------------------------------------------------------"
        Users.find_or_create_by(name: @user_name)
    end
    
    def prompt_to_show_saved_deals
        puts "--------------------------------------------------------------------"
        puts ""
        puts "Would you like to see your saved deals? Y or N"
        
        @input = gets.strip.downcase
        puts ""
        puts "--------------------------------------------------------------------"

        if @input == "y"
            show_saved_deals
        elsif @input == "n"
            select_another_deal
        else 
            invalid_input
            prompt_to_show_saved_deals
        end

    end

    
    def show_saved_deals
        puts ""
        puts "--------------------------------------------------------------------"
        puts ""
        puts "YOUR SAVED DEALS"
        puts ""
        puts "--------------------------------------------------------------------"
        #get id of selected_user
        user = Users.find_by(name: @user_name)
        deals_from_user = SavedDeals.select {|deal| deal.user_id == user.id}
        deals_from_user.each.with_index(1) do |deal, index|
            puts "#{index}." 
            puts deal.print
        end
    end

    def select_another_deal
        puts "--------------------------------------------------------------------"
        puts ""
        puts "Would you like to check out another deal? Y or N"
        puts "To delete a saved deal type D"
        @input = gets.strip.downcase

            if @input == "y"
                puts ""
                puts "--------------------------------------------------------------------"
                @city_input = ""
                @category_input = ""
                prompt_user_city
            elsif @input == "n" || @input == "quit"
                goodbye
            elsif @input == "d"
                delete_record
                select_another_deal
            else  
                invalid_input
                select_another_deal
            end
    end

    

    def delete_record 
        puts "--------------------------------------------------------------------"
        puts ""
        puts "Type in the number of the deal you would like to delete"
        @input = gets.strip.downcase
        puts ""
        puts "--------------------------------------------------------------------" 
        
        if @input.to_i != 0 && @input.to_i <= SavedDeals.all.size
            SavedDeals.all.delete_from_db(input.to_i)
            prompt_to_show_saved_deals
            select_another_deal
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
        puts ""
        puts "Hope to see you again soon for more deals!"
        puts ""
        puts "--------------------------------------------------------------------"
        exit
    end
end