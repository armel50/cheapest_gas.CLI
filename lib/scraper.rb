require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper 
    attr_accessor :zip_code
    def initialize(zip_code)
        @zip_code = zip_code
    end

    def self.sraper_the_cheapest_nearby(url) 
        title = Nokogiri::HTML(open(url)).css("h2.SearchResultsPage__resultsHeader___3FgQj").text
     
   
     
        gas_stations = Nokogiri::HTML(open(url)).css("div.GenericStationListItem__stationListItem___3Jmn4")
        gas_stations.collect do |station|
          
           {name: station.css("h3 a").text, price: station.css("div.GenericStationListItem__priceContainer___YbVoO").css("span.text__left___1iOw3").text,address: station.css("div.GenericStationListItem__address___1VFQ3").text, detail_url: station.css("h3 a").attribute("href").value    } if station.css("h3 a").attribute("href").value  
        end 
        
       
        
    end

    def self.scraper_detailled_info(url)  
       details = Nokogiri::HTML(open(url)) 
       prices = details.css("div.carousel__scrollContainer___hDjMb")
      array_of_prices_info = details.css("div.carousel__scrollContainer___hDjMb").css("div.GasPriceCollection__fuelTypePriceSection___3iGR-")
    # array_of_prices_info.first.css(" .text__xl___2MXGo text__bold___1C6Z_ text__left___1iOw3 FuelTypePriceDisplay__price___3iizb").text


      new_array = array_of_prices_info.collect do |price| 
            type_of_gas = price.css("span").first.text 
            price_of_gas = price.css("span")[price.css("span").index(price.css("span").first) + 1 ].text

        las_report = price.css("p").text

        {:type_of_gas => type_of_gas, :price_of_gas => price_of_gas, :las_report => las_report}
      end 
   
      rating = details.css("div.Reviews__reviewComponentContainer___3Njgz").css("div.panel__panel___3Q2zW.panel__white___19KTz.colors__bgWhite___1stjL.panel__bordered___1Xe-S.panel__rounded___2etNE").css("span").first.text
      {new_array:new_array,rating:rating}
     
    end
    
end 


