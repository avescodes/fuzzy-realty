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
        FuzzyRealty::LOCN[param.desired][listing.location]
      end
  }
  
  # Chosen weights are largely arbitrary. Expert was consulted for relative ratings, 
  # but as the knowledge engineer I was forced to pick the crisp values. 
  # Experimentation with larger user groups would likely show specific values to do 
  # better 
  WEIGHTS = {
    :sqft => 15, 
    :price => 10, 
    :location => 25
  }

  # A is a high-class suburb
  # B is a middle-class area
  # C is an older middle-class area
  # D is a "ghetto"
  #   A    B      C   D
  # A 1.0  0.75  0.2  0.0
  # B 0.75 1.00  0.4  0.1
  # C 0.2  0.4   1.0  0.6
  # D 0.0  0.1   0.6  1.0  
  LOCN = {
    'A' => {'A' => 1.0,  'B' => 0.75, 'C' => 0.2, 'D' => 0.0}, 
    'B' => {'A' => 0.75, 'B' => 1.0,  'C' => 0.4, 'D' => 0.1},
    'C' => {'A' => 0.2,  'B' => 0.4,  'C' => 1.0, 'D' => 0.6},
    'D' => {'A' => 0.0,  'B' => 0.1,  'C' => 0.6, 'D' => 1.0}
  }
end