module FuzzyRealty
  class Listing
    attr_accessor :price, :sqft, :location, :style
    def initialize(values={})
      values.each_key {|k| instance_variable_set(:"@#{k}", values[k])}
    end
  end
  
  class Query
    attr_accessor :params
    def initialize(params)
      @params = params
    end
  end
  
  class Parameter
    attr_accessor :required, :type, :desired, :style
    def initialize(type,desired,required=false)
      @required,@type,@desired = required, type, desired
    end
  end
end