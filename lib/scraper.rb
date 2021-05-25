require_relative './deals.rb'
class Scraper

    def self.get_page(input)
        puts "Input from scraper #{input}"
        base_url = "https://www.scoopon.com.au"
        full_url = "#{base_url}/#{input[0]}/#{input[1]}"
        doc = Nokogiri::HTML(open(full_url))
        make_instances(doc, full_url)
    end

    self.make_instances(scraped_page, url)
    deal_cards = scraped_page.css("div.deal-item")
    deal_cards.each do |deal|
        title = deal.css("h3.deal-title span").text.strip
        url_params = deal.css("a").attribute("href").value
        
        if !title.empty? && !url_params.empty?
            deal_instance = Deals.new
            deal_instance.title = title
            deal_instance.url = base_url + url_params
            puts deal_instance.url
            deal_instance.location = 
            "#{deal.css(".deal-subtitle span.specific").text.strip} - #{deal.css(".deal-subtitle span.general").text.strip}"
            
            deal_instance.price = deal.css('a div.deal-pricing div.price-box div.price-text').text.strip
            deal_instance.promotion = deal.css('div.deal-saving').text.strip
            get_more_details(deal_instance, deal_instance.url)
        end
        binding.pry
    end
end


    ##Create function for each loop above
    #

    def self.get_more_details(deal_instance, url)
        doc = Nokogiri::HTML(open(url))
        deal_instance.about = doc.css('.styles__Content-sc-14qr04h-6').text.strip
        binding.pry
    end
end