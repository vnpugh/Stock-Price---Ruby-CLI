require_relative 'user'
require_relative 'scraper'
require_relative 'stock'

class CLI
  # run method
  def run
    User.load_users_from_file
    greeting
    menu
  end

  # greeting method
  def greeting
    puts "Welcome to the Stock Price CLI!"
  end

  # scrap stock data method
  def scrape_data
    puts "Please enter the stock symbol you want to lookup (e.g., AAPL for Apple):"
    stock_symbol = gets.strip.upcase
    return if stock_symbol.empty?

    stock_data = Scraper.scrape_data(stock_symbol)

    if stock_data && stock_data[:price] && stock_data[:range] && stock_data[:ratio]
      puts "Stock Symbol: #{stock_symbol}"
      puts "Stock Name: #{stock_data[:name]}"
      puts "Current Price: $#{stock_data[:price]}"
      puts "Day's Range: #{stock_data[:range]}"
      puts "PE Ratio: #{stock_data[:ratio]}"

    else
      puts "Could not retrieve data for '#{stock_symbol}'. Check the symbol and try again."
    end
  end  # Added missing end

  # Main menu method
  def menu
    loop do
      puts "\nPlease enter a menu option by number:"
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
        User.sign_up
      when 3
        login
      when 4
        logout
      when 5
        User.reset_password
      when 6
        puts "Goodbye! Thank you for using the Stock Price CLI."
        exit
      else
        puts "Invalid input, please try again."
      end
    end
  end  # Added missing end

  # Login method
  def login
    puts "Please enter your username:"
    username = gets.strip
    puts "Please enter your password:"
    password = gets.strip

    if User.authenticate(username, password)
      puts "Login successful! Welcome back, #{username}."
    else
      puts "Login failed. Incorrect username or password."
    end
  end  # Added missing end

  # Logout method
  def logout
    puts "You have been logged out successfully."
  end
end  # This end closes the CLI class

if __FILE__ == $0
  cli = CLI.new
  cli.run
end
