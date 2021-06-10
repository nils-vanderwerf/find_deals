
class FindDeals::CLI
    attr_accessor :city_input, :category_input, :input, :user_name, :selected_deal


    def initialize 
        # @deals = FindDeals::SavedDeals.all
        @user_name = ""
        @input = ""
        @city_input = ""
        @category_input = ""
        @selected_deal
        @page = 1
        @max = 5
    end

    def call
        puts "--------------------------------------------------------------------"
        puts ""
        puts "Welcome to this amazing promo finder!"
        puts ""
        start
    end

    def start
            #-----LIST OF METHODS---#
            prompt_user_city
            prompt_user_category
            if FindDeals::Deal.all.length != 0 
                print_deals
                print_more_info
                prompt_to_save_deal
                prompt_to_show_saved_deals
                next_steps
            else 
                start
            end
    end

    def prompt_user_city
        puts "--------------------------------------------------------------------"
        puts ""
        puts "Select a city (type in corresponding number)"
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
        get_city_input
    end

    def get_city_input
        @input = gets.strip
        @input != 'quit' ? @city_input = select_city_from_input : goodbye
    end

    def select_city_from_input
        while @input.to_i == 0 || @input.to_i > Cities.all.size
            invalid_input
            prompt_user_city
        end
            Cities.find(@input).name # Collects it from the database 
    end

    def select_category_from_input
        while @input.to_i == 0 || @input.to_i > Categories.all.size
            invalid_input
            prompt_user_category
        end
            Categories.find(@input).name ## Collects it from the database 
    end

    def prompt_user_category
        puts "----------------------------------------------------------------"
        puts ""
        puts "Select a category (type in corresponding number)"
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
        get_category_input
    end

    def get_category_input
        @input = gets.strip
        check_quit_input_and_goodbye
        @category_input = select_category_from_input

        if @input.to_i == 0 || @input.to_i > Categories.all.length
            invalid_input
            get_category_input
        end
        @category_input = Categories.find(input).name
        site_scraper = FindDeals::Scraper.new(@city_input, @category_input)
        if FindDeals::Deal.all.length == 0
            puts "--------------------------------------------------------------------"
            puts ""
            puts "Sorry! No deals for this selection today. Please try another selection."
            puts ""
            puts "--------------------------------------------------------------------"
        end
    end

    def print_deals
        puts "--------------------------------------------------------------------"
        puts ""
        puts "DEALS FOR THIS INPUT"
        puts ""
        
       print_deals_per_page
    end

    def print_deals_per_page
        #Show 5 deals at a time of deals
            FindDeals::Deal.all.slice(@max * (@page - 1), @max).each.with_index((@max * (@page - 1)) + 1) do |deal, index|
                puts "#{index}." 
                puts deal.print    
        end
        display_other_pages
    end

    def display_other_pages
        puts "To continue type cont"
        if @page * @max < FindDeals::Deal.all.length
            puts "Go to next page? Type next"
        else 
            puts "--------------------------------------------------------------------"
            puts ""
            puts "NO MORE DEALS"
            puts "To continue type cont"
            puts ""
            
        end

        if @page * @max > @max
            puts "Go to previous page? Type prev"
        end

        @input = gets.strip.downcase

        if @input == "next"
            @page += 1 
            print_deals_per_page
        elsif @input == "prev"
            @page -= 1
            print_deals_per_page

        elsif @input == "cont"
            print_more_info
        else
            invalid_input
            print_deals_per_page
        end
        puts "Type cont to continue"
    end
    
    def print_more_info
       
        if FindDeals::Deal.all.length != 0
            puts "--------------------------------------------------------------------"
            puts ""
            puts "Please enter the number of the deal you'd like to see more about. Type in quit to exit"
            puts ""
            @input = gets.strip
            check_quit_input_and_goodbye
            @input = @input.to_i
            while @input == 0 || @input > FindDeals::Deal.all.size
                invalid_input
                @input = gets.strip.to_i
            end
            FindDeals::Deal.all[@input - 1].print_about_details
            @selected_deal = FindDeals::Deal.all[@input - 1]
        else
            puts "--------------------------------------------------------------------"
            puts ""
            puts "Sorry! No deals for this selection today. Please try another selection."
            puts ""
            puts "--------------------------------------------------------------------"
        end
        
        
    end

    def prompt_to_save_deal
        puts ""
        puts "Would you like to save this deal? Y or N"
        @input = gets.strip.downcase
        puts ""
        puts "--------------------------------------------------------------------"
        if @input == "y"
            user = get_user
            puts "Saving deal..."
            puts ""
            puts "--------------------------------------------------------------------"
            
            @selected_deal.save(user.id) ##save to Saved Deals, with the user id as the User_id
        elsif @input == "n"
            next_steps
        elsif check_quit_input_and_goodbye 
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
        @input = gets.strip
        if @input != 'quit'
            puts "--------------------------------------------------------------------"
            @user_name = input
            Users.find_or_create_by(name: @user_name)
        else
            check_quit_input_and_goodbye
        end
    end
    
    def prompt_to_show_saved_deals
        puts ""
        puts "Would you like to see your saved deals? Y or N"
        
        @input = gets.strip.downcase
        puts ""
        puts "--------------------------------------------------------------------"

        if @input == "y"
            show_saved_deals
        elsif @input == "n"
            next_steps
        elsif check_quit_input_and_goodbye
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

    def filter_by_city
        puts ""
        puts "--------------------------------------------------------------------"
        puts ""
        puts "YOUR SAVED DEALS IN #{city_input.upcase.split('-').join(' ')}"
        puts ""
        puts "--------------------------------------------------------------------"
        #get id of selected_user
        user = Users.find_by(name: @user_name)
        deals_from_city = SavedDeals.select {|deal| deal.user_id == user.id && deal.city_id == @input.to_i}
        if deals_from_city.length == 0 
            puts "Sorry! No saved deals for this section. Please try another selection."
            next_steps
        end
        deals_from_city.each.with_index(1) do |deal, index|
            puts "#{index}." 
            puts deal.print
        end
    end

    def filter_by_category
        puts ""
        puts "--------------------------------------------------------------------"
        puts ""
        puts "YOUR SAVED DEALS IN THE #{@category_input == nil ? 'ALL DEALS' : @category_input.upcase.split('-').join(' ')} CATEGORY"
        puts ""
        puts "--------------------------------------------------------------------"
        #get id of selected_user
        user = Users.find_by(name: @user_name)
        deals_from_category = SavedDeals.select {|deal| deal.user_id == user.id && deal.category_id == @input.to_i}
        if deals_from_category.length == 0 
            puts "Sorry! No saved deals for this section. Please try another selection."
            next_steps
        end
        deals_from_category.each.with_index(1) do |deal, index|
            puts "#{index}." 
            puts deal.print
        end
    
    end

    def next_steps
        puts "--------------------------------------------------------------------"
        puts ""
        puts "What would you like to do now"
        puts "- To view more deals, type 'MORE'"
        puts "- To filter your saved deals by city, type in 'CITY'"
        puts "- To filter your saved deals by category, type in 'CATEGORY'"
        puts "- To delete a saved deal type 'DELETE'"
        puts "- To quit, type in quit"
        @input = gets.strip.downcase

        if @input == "more"
            puts ""
            puts "--------------------------------------------------------------------"
            # start program again
            start #
        elsif @input == 'city'
            puts ""
            puts "--------------------------------------------------------------------"
            prompt_user_city
            filter_by_city
            next_steps
        elsif @input == 'category'
            prompt_user_category
            filter_by_category
            next_steps
        elsif @input == "delete"
            delete_record
            next_steps
        elsif check_quit_input_and_goodbye
        else  
            invalid_input
            next_steps
        end
    end

    def delete_record 
        user = get_user
        show_saved_deals
        puts "--------------------------------------------------------------------"
        puts ""
        puts "Type in the number of the deal you would like to delete"
        puts ""
        puts "--------------------------------------------------------------------" 
        @input = gets.strip.downcase

        while @input.to_i == 0 || @input.to_i >= SavedDeals.select {|deal| deal.user_id == user.id}.length
            invalid_input
            puts "--------------------------------------------------------------------"
            puts ""
            puts "Type in the number of the deal you would like to delete"
            puts ""
            puts "--------------------------------------------------------------------" 
            @input = gets.strip.downcase
            
            check_quit_input_and_goodbye
        end 

        SavedDeals.all.delete_from_db(user, @input.to_i)
        prompt_to_show_saved_deals
        next_steps

    end

    def invalid_input
        puts "--------------------------------------------------------------------"
        puts ""
        puts "Invalid input. Please try again"
        puts ""
        puts "--------------------------------------------------------------------"
    end

    # def input=(input)
    #     input == 'quit' ? goodbye : @input = input
    # end

    def check_quit_input_and_goodbye
        if @input == 'quit'
            goodbye
        end
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