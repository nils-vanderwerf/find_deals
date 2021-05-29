class FindDeals::Scraper

    attr_accessor :html, :doc, :full_url
    attr_reader :base_url

    def initialize(city, category)
        @base_url = "https://www.scoopon.com.au"
        @full_url = "#{@base_url}/#{city}/#{category}"
        @html = open(@full_url)
        @doc = Nokogiri::HTML(@html) #Nokogiri is an API for reading and witing XML and HTML from ruby
        make_instances
    end

    def make_instances
    deal_cards = @doc.css("div.deal-item")
    deal_cards.collect do |deal|
        title = deal.css("h3.deal-title span").text.strip
        url_params = deal.css("a").attribute("href").value
        
        
        if !title.empty? && !url_params.empty?
            url = url_params.include?(@base_url) ? url_params : @base_url + url_params
            location = 
            "#{deal.css(".deal-subtitle span.specific").text.strip} - #{deal.css(".deal-subtitle span.general").text.strip}"
            
            price = deal.css('a div.deal-pricing div.price-box div.price-text').text.strip
            promotion = deal.css('div.deal-saving').text.strip
            #store the page for that deal instance
            about_info = get_more_info(url)
            about = about_info.css('.styles__Content-sc-14qr04h-6').text.strip
            #Limit to 10 results
            if FindDeals::Deal.all.length < 10 
                FindDeals::Deal.new(title: title, url: url, location: location, price: price, promotion: promotion, about: about)
            end
        end 
    end
    # binding.pry
    end

    def get_more_info(url)
        more_info_url = open(url)
        more_info_page = Nokogiri::HTML(more_info_url)
    end


end
