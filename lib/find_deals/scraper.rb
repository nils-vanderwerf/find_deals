class FindDeals::Scraper

    attr_accessor :html, :doc, :full_url
    attr_reader :base_url

    def initialize(city = "sydney", category = "")
        @base_url = "https://www.scoopon.com.au"
        @full_url = "#{@base_url}/#{city}/#{category}"
        @html = open(@full_url)
        @doc = Nokogiri::HTML(@html)
        make_instances
    end

    def make_instances
    deal_cards = @doc.css("div.deal-item")
    deal_cards.collect do |deal|
        title = deal.css("h3.deal-title span").text.strip
        url_params = deal.css("a").attribute("href").value
        
        if !title.empty? && !url_params.empty?
            url = @base_url + url_params
            location = 
            "#{deal.css(".deal-subtitle span.specific").text.strip} - #{deal.css(".deal-subtitle span.general").text.strip}"
            
            price = deal.css('a div.deal-pricing div.price-box div.price-text').text.strip
            promotion = deal.css('div.deal-saving').text.strip
            about = doc.css('.styles__Content-sc-14qr04h-6').text.strip
            FindDeals::Deal.new(title: title, url: url, location: location, price: price, promotion: promotion)
        end 
    end
end


end
