module FuzzyRealty
  RULES = {
    # Not yet implemented
    :bathrooms => 1,
    :garage => 1,
    :deck => 1,
    
    # Price is match when desired is 90-105%  of actual. Otherwise give a
    # reduced factor.
    :price => 
      lambda do |listing,desired| 
        puts "Called price" if $debug
        actual = listing.price.to_f
        result = if (desired*0.90..desired*1.05) === actual
          1.0
        else 
          1 - ((desired - actual) / actual).abs
        end
        puts result if $debug
        result
      end,
  
    # Location calc. does lookup to find score for desired and actual
    ## Currently just return 1 if exact, 0 otherwise
    :location => 
      lambda do |listing,desired|
        puts "Called location" if $debug
        # Perform a quick lookup (i.e. FuzzyRealty::LOCN[:A][:A] => 1.0)
        puts FuzzyRealty::LOCN[desired.to_sym][listing.location.to_sym] if $debug
        FuzzyRealty::LOCN[desired.to_sym][listing.location.to_sym]
      end,
      
    :sqft => 
      lambda do |listing,desired|
                puts "Called sqft" if $debug
        actual = listing.sqft
        result = if (actual + 50) >= desired
          1.0
        elsif (actual + 150) >= desired
          0.8
        elsif (actual + 300) >= desired
          0.5
        else
          0.0
        end
        puts result if $debug
        result
      end,
    # Style's follow lookup table similar to Location

    :style => 
      lambda do |listing,desired|
                puts "Called style" if $debug
        desired = FuzzyRealty::STYLE[:Symbol][desired]
        actual  = FuzzyRealty::STYLE[:Symbol][listing.style]
        puts FuzzyRealty::STYLE[desired][actual] if $debug
        FuzzyRealty::STYLE[desired][actual]
      end
  }
end