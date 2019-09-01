 require "/Users/home/Desktop/learn.co/cheapest_gas_CLI/lib/gas_station.rb"
 require "/Users/home/Desktop/learn.co/cheapest_gas_CLI/lib/scraper.rb"
require 'nokogiri'
require 'colorize' 
require 'pry'


class CommandLineInterface 
attr_accessor :url

  def initialize 
   welcome
   proccess
  end

  def welcome 
    puts "--------------------------------------------------"
    puts "|      Welcome To Our Wonderful CLI              |"
    puts "|                                                |"
    puts "--------------------------------------------------"
    puts ""
    puts ""
  end 

  def zip_code? 
    puts "Do you want to know the cheapest gas stations near you?"
  end 
  


  def proccess  
    zip_code? 
    answer_to_zip_code = gets.strip 
    if ["Yes","Y"].include?(answer_to_zip_code.upcase) 
      puts " yayyy! You can now enter your zip code"
      the_user_zip_code = gets.strip
      scraper = Scraper.new(the_user_zip_code)
      
      url ="https://www.gasbuddy.com/home?search=#{scraper.zip_code}&fuel=1" 
      gas_stations = scraper.class.sraper_the_cheapest_nearby(url)
     
   
      Gas_station.create_gas_station_from_data(gas_stations)
      
     
      display
      
      
      puts "Do you want detailled Information? (yes/no)" 
      more_info_answer = gets.strip 

      ["YES","Y"].include?(more_info_answer.upcase) ? more_info : nil

      
    else 
      puts "Goodbye!!!!"
    end
  end

  def valid?(zip_code)
    true if zip_code.to_i != 0
  end

  def display
    # puts "#{@search}".colorize(:blue) 
    
    Gas_station.all.each do |gas_station|
      puts "=====================================================================================".colorize(:blue)
      puts "Gas Station: ".colorize(:green) + "#{gas_station.name}".colorize(:yellow)
      puts "price: ".colorize(:green) + "#{gas_station.price}".colorize(:yellow)
      puts "Gas Address: ".colorize(:green) + "#{gas_station.address}".colorize(:yellow)
      puts "=====================================================================================".colorize(:blue)
      puts "" 
      puts ""
    end 

    
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
      puts "Overal Price: ".colorize(:green) + "#{gas_station.price}".colorize(:yellow)
      gas_station.new_array.each do |el|
        puts "        Type of Gas: " + "#{el[:type_of_gas]}"
        puts "            Price of Gas: " + "#{el[:price_of_gas]}"
        puts "             Reported: " + "#{el[:las_report]}"
      end 
      puts  "Overall Rating: " + "#{gas_station.rating}"
      puts "Gas Address: ".colorize(:green) + "#{gas_station.address}".colorize(:yellow)
      puts "=====================================================================================".colorize(:blue)
      puts "" 
      puts ""
    end
  end
end 

