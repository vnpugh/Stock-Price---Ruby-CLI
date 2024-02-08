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
      
      # Define Yahoo Finance CSS selectors
      name_selector = 'div.D\(ib\) > h1.D\(ib\).Fz\(18px\)'
      price_selector = 'td.Ta\(end\).Fw\(600\).Lh\(14px\)[data-test="OPEN-value"]'
      range_selector = 'td.Ta\(end\).Fw\(600\).Lh\(14px\)[data-test="DAYS_RANGE-value"]'
      ratio_selector = 'td.Ta\(end\).Fw\(600\).Lh\(14px\)[data-test="PE_RATIO-value"]'

      #Need to extract the name, price, range & ratio
      #name
      name = parsed_page.css(name_selector).text.strip
      #price
      price_element = parsed_page.at_css(price_selector)
      price = price_element.content.strip if price_element
      #range
      range_element = parsed_page.at_css(range_selector)
      range = range_element.content.strip if range_element
      #ratio
      ratio_element = parsed_page.at_css(ratio_selector)
      ratio = ratio_element.content.strip if ratio_element





      # Constructed scraped data hash
      scraped_data = {
        name: name,
        price: price,
        range: range,
        ratio: ratio
      }

      # Return the scraped data
      scraped_data
    end
  end
end
