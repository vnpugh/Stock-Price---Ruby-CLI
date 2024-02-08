require_relative "./lib/cli.rb"
#require "bcrypt"

# start CLI

CLI.new.run

=begin
my_password = BCrypt::Password.create("my password")

puts my_password == "my password" # true

puts my_password == "not my password" # false
=end
