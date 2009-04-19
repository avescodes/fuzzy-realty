module FuzzyRealty
  METHODS = {
    # Not yet implemented
    :bathroom => 1,
    :garage => 1,
    :deck => 1,
    
    # Price is match when desired is 90-105%  of actual. Otherwise give a
    # reduced factor.
    :price => 
      lambda do |listing,param| 
        puts "Called price"
        actual,desired = listing.price.to_f, param.desired
        result = if (desired*0.90..desired*1.05) === actual
          1.0
        else 
          1 - ((desired - actual) / actual).abs
        end
        puts result
        result
      end,
  
    # Location calc. does lookup to find score for desired and actual
    ## Currently just return 1 if exact, 0 otherwise
    :location => 
      lambda do |listing,param|
        puts "Called location"
        # Perform a quick lookup (i.e. FuzzyRealty::LOCN[:A][:A] => 1.0)
        puts FuzzyRealty::LOCN[param.desired.to_sym][listing.location.to_sym]
        FuzzyRealty::LOCN[param.desired.to_sym][listing.location.to_sym]
      end,
      
    :sqft => 
      lambda do |listing,param|
                puts "Called sqft"
        actual, desired = listing.sqft, param.desired
        result = if (actual + 50) >= desired
          1.0
        elsif (actual + 150) >= desired
          0.8
        elsif (actual + 300) >= desired
          0.5
        else
          0.0
        end
        puts result
        result
      end,
    # Style's follow lookup table similar to Location

    :style => 
      lambda do |listing,param|
                puts "Called style"
        desired = FuzzyRealty::STYLE[:Symbol][param.desired]
        actual  = FuzzyRealty::STYLE[:Symbol][listing.style]
        puts FuzzyRealty::STYLE[desired][actual]
        FuzzyRealty::STYLE[desired][actual]
      end
  }
end