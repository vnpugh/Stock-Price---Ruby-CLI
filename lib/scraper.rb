require 'nokogiri'
require 'httparty'
require 'open-uri'

class Scraper
  def self.scrape_data(stock_symbol)
    # Replace placeholder with actual stock symbol
    url = "https://finance.yahoo.com/quote/#{stock_symbol}"

    response = HTTParty.get(url)
    if response.body.nil? || response.body.empty?
      puts "No data received from the server."
      return nil
    else
      parsed_page = Nokogiri::HTML(response.body)
      
      # Yahoo Finance CSS selectors
      name_selector = 'div.quote-header-info h1'
      price_selector = '[data-field="regularMarketPrice"]'
      change_selector = '[data-field="regularMarketChangePercent"]'

      name = parsed_page.css(name_selector).text.strip
      price = parsed_page.css(price_selector).text.strip
      change = parsed_page.css(change_selector).text.strip

      # Constructed scraped data
      scraped_data = {
        name: name,
        price: price,
        change: change
      }

      # Return the scraped data
      scraped_data
    end
  end
end
