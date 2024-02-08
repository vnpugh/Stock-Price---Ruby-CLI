require 'bcrypt'
require 'json'

class User
  attr_accessor :username, :password

  @@users = []

  def initialize(username, password, password_pre_hashed: false)
    @username = username
    @password = password_pre_hashed ? BCrypt::Password.new(password) : BCrypt::Password.create(password)
    @@users << self
  end

  def self.load_users_from_file
    file_path = 'users.json'
    return unless File.exist?(file_path)

    users_data = JSON.parse(File.read(file_path))
    users_data.each do |user_data|
      new(user_data['username'], user_data['password'], password_pre_hashed: true)
    end
  end

  def self.find_by_username(username)
    @@users.find { |user| user.username == username }
  end

  def self.authenticate(username, password)
    user = find_by_username(username)
    user && BCrypt::Password.new(user.password) == password ? user : nil
  end

  def self.sign_up
    puts "Please enter a new username:"
    username = gets.strip
    return puts "Username cannot be blank" if username.empty?

    if find_by_username(username)
      puts "Username already exists. Please choose a different username."
      return
    end

    puts "Please enter a new password:"
    password = gets.strip
    return puts "Password cannot be blank" if password.empty?

    new(username, password)
    store_all_credentials
    puts "User #{username} created successfully."
  end

  def self.reset_password
    puts "Please enter your username:"
    username = gets.strip
    user = find_by_username(username)

    unless user
      puts "Username not found."
      return
    end

    puts "Please enter your current password:"
    current_password = gets.strip
    unless BCrypt::Password.new(user.password) == current_password
      puts "Incorrect password."
      return
    end

    puts "Please enter your new password:"
    new_password = gets.strip
    user.password = BCrypt::Password.create(new_password)
    store_all_credentials
    puts "Password updated successfully."
  end

  def self.store_all_credentials
    file_path = 'users.json'
    users_data = @@users.map { |user| { 'username' => user.username, 'password' => user.password } }
    File.write(file_path, JSON.generate(users_data))
  end
end
