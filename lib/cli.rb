require_relative 'user'
require_relative 'scraper'
require_relative 'stock'

class CLI
 # run method
  def run
    User.load_users_from_file
    greeting
    authenticate

    puts "Please enter the stock symbol you want to lookup (e.g., AAPL for Apple):"
    stock_symbol = gets.strip.upcase

    # Pass only the stock symbol to Scraper.scrape_data
      stocks = Scraper.scrape_data(stock_symbol)

    
    end_program
  end


      # greeting method
      def greeting
        puts "Welcome to the Stock Price CLI!"
      menu
    end

      # scrap stock data method
      def scrape_data(attempts = 3)
        if attempts <= 0
           puts "Too many invalid attempts. Returning to the main menu."
        menu
      return
    end
  
        puts "Please enter the stock symbol you want to lookup (e.g., AAPL for Apple):"
        stock_symbol = gets.strip.upcase
  
        if stock_symbol.empty?
          puts "The Stock symbol cannot be empty. Please try again."
          scrape_data(attempts - 1)  # Decrement the number of attempts left and call recursively
               else
                  stock_data = Scraper.scrape_data(stock_symbol)
  
        if stock_data && stock_data[:price] && stock_data[:change]
          puts "Stock Symbol: #{stock_symbol}"
          puts "Stock Name: #{stock_data[:name]}" 
          puts "Current Price: #{stock_data[:price]}"
          puts "Change: #{stock_data[:change]}"
             else
                puts "Could not retrieve data for '#{stock_symbol}'. Check the symbol and try again."
          end
        end
           menu  # Return to main menu
     end


       # Main menu method
  def menu
    puts "Please enter a menu option by number:"
    puts "1. Lookup A Stock"
    puts "2. Sign Up"
    puts "3. Login"
    puts "4. Logout"
    puts "5. Reset Password"
    puts "6. Exit"

    input = gets.strip.to_i

  case input
    when 1
      scrape_data
    when 2
      sign_up
    when 3
      login
    when 4
      logout
    when 5
      reset_password
    when 6
      puts "Goodbye!"
      exit
    else
      puts "Invalid input, please try again."
      menu
    end
  end


  # End program method
  def end_program
    puts "Thank you for using the Stock Price CLI. Have a great day!"
  end
end

if __FILE__ == $0
  cli = CLI.new
  cli.run
end
