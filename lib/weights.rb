module FuzzyRealty
  # Chosen weights are largely arbitrary. Expert was consulted for relative ratings, 
  # but as the knowledge engineer I was forced to pick the crisp values. 
  # Experimentation with larger user groups would likely show specific values to do 
  # better 
  WEIGHTS = {
    :sqft => 15, 
    :price => 10, 
    :location => 25,
    :style => 18
  }
  
  def self.max_score
    WEIGHTS.inject(0) {|sum,n| sum + n[1]}
  end
end