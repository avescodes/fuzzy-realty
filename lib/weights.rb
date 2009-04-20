module FuzzyRealty
  # Chosen weights are largely arbitrary. Expert was consulted for relative ratings, 
  # but as the knowledge engineer I was forced to pick the crisp values. 
  # Experimentation with larger user groups would likely show specific values to do 
  # better 
  
  # class Parameter uses this hash to determine what is a valid type. 
  # - This must be matched by a rule in rulebase.rb
  WEIGHTS = {
    :sqft => 15, 
    :price => 10, 
    :location => 25,
    :style => 18
  }
  
  # Easy way to sum the max score (for testing)
  def self.max_score
    WEIGHTS.inject(0) {|sum,n| sum + n[1]}
  end
end