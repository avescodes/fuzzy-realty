module FuzzyRealty
  METHODS = {
    # Price is match when desired is 90-105%  of actual. Otherwise give a
    # reduced factor.
    :price => 
      lambda do |listing,param| 
        actual,desired = param.desired,listing.price.to_f
        if (desired*0.90..desired*1.05) === actual
          1
        else 
          1 - ((desired - actual) / actual).abs
        end
      end,
  
    # Location calc. does lookup to find score for desired and actual
    ## Currently just return 1 if exact, 0 otherwise
    :location => 
      lambda do |listing,param|
        actual,desired = param.desired,listing.location
        actual == desired ? 1 : 0
      end
  }
  
  WEIGHTS = {
    :sqft => 5, 
    :price => 10, 
    :location => 25
  }
end