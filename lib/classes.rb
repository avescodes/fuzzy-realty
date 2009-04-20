module FuzzyRealty
  # Stub for testing without Rails project
  class Listing
    attr_accessor :price, :sqft, :location, :style
    def initialize(values={})
      values.each_key {|k| instance_variable_set(:"@#{k}", values[k])}
    end
    def self.random
      FuzzyRealty::Listing.new({
        :price => 20_000 + rand(250_000),
        :sqft => 300 + rand(2000),
        :location => %W{A B C D}[rand(4)],
        :style => %W{Bungalow Bi-level Split-level Two-story Condominium}[rand(5)]
      })
    end
  end
  class Query
    attr_reader :params
    def initialize(params=[])
      @params = params
    end
    def << (param)
      if !param.is_a?(Parameter)
        raise "Attempting to add non-Parameter to Query" 
      end
      @params << param

    end
    def self.random
      query = Query.new
      query << Parameter.new(:price, 20_000 + rand(250_000),  [true,false][rand(1)])
      query << Parameter.new(:sqft,  300 + rand(2000),        [true,false][rand(1)])
      query << Parameter.new(:location, %W{A B C D}[rand(4)], [true,false][rand(1)])
      query << Parameter.new(
        :style,   
        %W{Bungalow Bi-level Split-level Two-story Condominium}[rand(5)],
        [true,false][rand(1)])
      query
    end
  end
  
  class Parameter
    attr_reader :type, :desired, :required
    def initialize(type,desired,required=false)
      if !Parameter.valid_types.contains(type)
        raise "Attempting to create non-existant Parameter type" 
      end
      @type     = type
      @desired  = desired
      @required = required
    end
    def self.valid_types
      FuzzyRealty::WEIGHTS.each_key.to_a
    end

  end
end

class Array
  def contains(value)
    self.any? {|array_value| array_value == value }
  end
end