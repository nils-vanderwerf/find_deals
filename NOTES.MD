  
  "Where are you"
  1.

  Which city are you hoping to find deals in ?
  1. Sydney
  2. Melbourne
  3. Perth
  4. Brisbane?
  5. Adelaide
  6. Gold Coast
  7. Other?
  
  If time, user types in postcode, translate that postcode into a URL *(scrape twice)

  "Which category are you hoping to find deals in?"
        1. Anything
        2. Dining
        3. Wellness & Beauty
        4. Activities
        5. Travel
        6. Shopping
        7. Services
        8. Wine
        9. Personalised Gifts

        Type in number of word

         input = nil
        while input != "quit"
            input = gets.strip
            case input
            when "Anything" || "1" 
              puts "Here are some great deals:"
            when "Dining" || "2"
                puts "Here are some great dining deals:"
            when "Wellness & Beauty" || "3"
                puts "Here are some great wellness & beauty deals:"
            when "Activities" || "4"
                puts "Here are some great deals on activities:"
            when "Travel" || "5"
                puts "Here are some great travel deals:"
            when "Shopping" || "6"
                puts "Here are some great shopping deals:"
            when "Services" || "7"
                puts "Here are some great services deals:"
            when "Wine" || "8"
                puts "Here are some great wine deals:"
            when "Personalised Gifts" || "9"
                puts "Here are some great personalised gifts deals:"
        
            end

            Sends an array to the scraper, which in turn appends it to the url

            A class is created using the each, which includes values for title