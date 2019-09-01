class Gas_station 
    @@all = []
    attr_accessor :name, :address, :price , :rating , :detail_url , :new_array

    def initialize(name:,address:,price:, detail_url:)
        @name = name 
        @address = address 
        @price = price 
        @detail_url = detail_url
        
    end

    def self.create_gas_station_from_data(array_of_gas_station) 
        array_of_gas_station.each do |gas_station|
             gas_object =self.new(gas_station) 
             @@all << gas_object if gas_object.price
        end

    end 

    def add_more_info(data)
        the_gas_station = self
        data.each do |key,val|
            # puts "#{key} #{val}"
            
             the_gas_station.send("#{key}=",val) 
        end

    end
  
    def self.all 
        @@all.sort_by{|gas_station| gas_station.price }
    end

end