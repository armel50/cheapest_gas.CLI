 require "/Users/home/Desktop/learn.co/cheapest_gas_CLI/lib/gas_station.rb"
 require "/Users/home/Desktop/learn.co/cheapest_gas_CLI/lib/scraper.rb"
require 'nokogiri'
require 'colorize' 
require 'pry'


class CommandLineInterface
  
  
  attr_accessor :url, :the_user_zip_code

    def initialize(the_user_zip_code = nil)
    welcome
    proccess
    end


    def welcome 
      puts "--------------------------------------------------".colorize(:light_blue)
      puts "|                                                |".colorize(:light_blue)
      puts "|         Welcome To Our Wonderful CLI           |".colorize(:light_blue)
      puts "|                                                |".colorize(:light_blue)
      puts "--------------------------------------------------".colorize(:light_blue)
      puts ""
      puts ""
    end 


    def proccess  
      puts "Would like to see the cheapest gas stations near you? (yes/no)"
      answer_to_zip_code = gets.strip 
     
      if ["YES","Y"].include?(answer_to_zip_code.upcase) 
        basic_info
        puts "Would you like more information? (yes/no)" 
        more_info_answer = gets.strip 
        ["YES","Y"].include?(more_info_answer.upcase) ? more_info : goodbye
      else 
        goodbye
      end

      
    end


    def valid?(zip_code)
      true if zip_code.to_i != 0 && zip_code.length == 5
    end


    def goodbye 
      puts "--------------------------------------------------".colorize(:light_blue)
      puts "|                                                |".colorize(:light_blue)
      puts "|               Goodbye!!!!!                     |".colorize(:light_blue)
      puts "|                                                |".colorize(:light_blue)
      puts "--------------------------------------------------".colorize(:light_blue)
      puts ""
      puts ""
    end
    

    def display
      Gas_station.all.each do |gas_station|
        puts "=====================================================================================".colorize(:blue)
        puts "Gas Station: ".colorize(:green) + "#{gas_station.name}".colorize(:yellow)
        puts "price: ".colorize(:green) + "#{gas_station.price}".colorize(:yellow)
        puts "Gas Address: ".colorize(:green) + "#{gas_station.address}".colorize(:yellow)
        puts "=====================================================================================".colorize(:blue)
        puts "" 
        puts ""
        puts ""
      end 
    end 
    

    def basic_info 
      puts "You can now enter your zip code."
      the_user_zip_code = gets.strip
      while !valid?(the_user_zip_code) do 
        puts "Please enter a valid zip code"
        @the_user_zip_code = gets.strip
      end
      url ="https://www.gasbuddy.com/home?search=#{the_user_zip_code}&fuel=1" 
      gas_stations = Scraper.scraper_the_cheapest_nearby(url)
      Gas_station.create_gas_station_from_data(gas_stations)
    
      display
    end


    def more_info 
      Gas_station.all.each do |gas_station| 
        new_info = Scraper.scraper_detailled_info("https://www.gasbuddy.com#{gas_station.detail_url}") 
        gas_station.add_more_info(new_info)
      end
      display_more_info 
    end


    def display_more_info 
      Gas_station.all.each do |gas_station|
        puts "=====================================================================================".colorize(:blue)
        puts "Gas Station: ".colorize(:green) + "#{gas_station.name}".colorize(:yellow)
        puts "Price: ".colorize(:green) + "#{gas_station.price}".colorize(:yellow)

        gas_station.new_array.each do |el|
          puts "--------------------------------------------------------------------------------------"
          puts "        Type of Gas: ".colorize(:green) + "#{el[:type_of_gas]}".colorize(:yellow)
          puts "       Price of Gas: ".colorize(:green) + "#{el[:price_of_gas]}".colorize(:yellow)
          puts "       Last Reported: ".colorize(:green) + "#{el[:last_report]}".colorize(:yellow)
          puts "--------------------------------------------------------------------------------------"
        end

        puts  "Overall Rating: ".colorize(:green) + "#{gas_station.rating}".colorize(:yellow)
        puts "Gas Address: ".colorize(:green) + "#{gas_station.address}".colorize(:yellow)
        puts "=====================================================================================".colorize(:blue)
        puts "" 
        puts ""
        puts ""
      end
    end

end 