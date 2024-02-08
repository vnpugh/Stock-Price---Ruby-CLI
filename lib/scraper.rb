
require 'nokogiri'
require 'httparty'
require 'open-uri'

class Scraper
  def self.scrape_data(stock_symbol)
     # placeholder URL for the stock symbol
     url_placeholder = "https://finance.yahoo.com/quote/{stock_symbol}"

    # Replace with actual stock symbol
     url = url_placeholder.gsub('{stock_symbol}', stock_symbol)

      unparsed_page = HTTParty.get(url)
      parsed_page = Nokogiri::HTML(unparsed_page)

    # Yahoo Finance CSS selectors
    name_selector = 'div.quote-header-info h1' 
    price_selector = '[data-field="regularMarketPrice"]' 
    change_selector = '[data-field="regularMarketChangePercent"]'

    name = parsed_page.css(name_selector).text.strip
    price = parsed_page.css(price_selector).text.strip
    change = parsed_page.css(change_selector).text.strip

    # Placeholder for scraped data
        scraped_data = {
           name: name,
           price: price,
           change: change
      }

    # Return the scraped data
      scraped_data

  end
end
