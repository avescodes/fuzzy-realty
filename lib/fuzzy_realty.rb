module FuzzyRealty
  class ExpertSystem
    def calculate_scores(listings, query)
      scores = []
      for listing in listings
        score = 0
        query.params.each do |param|
          #calculate score modifier of parameter using $methods global
          change = $methods[param.type].call(listing,param)
          # if score is bad and parameter is required then reduce it further
          change = (change < 0.70 and param.required) ? (change - 1) : change
          score += change * @@weights[param.type]
        end
        scores << {listing => score}
      end
      return scores
    end
  end

  # Have a table of ways to calculate the score modifier
  # --> i.e. price will allow cheaper, sqft will allow bigger, etc.

  es = ExpertSystem.new()

  # Creating a library of stub models
  a = Listing.new({:price => 112000, :sqft => 720, :location => 'A'})
  b = Listing.new({:price => 142000, :sqft => 1420, :location => 'B'})
  # The user wants price around 110k and in location A, 
  p1 = Parameter.new(false,:price,110000)
  p2 = Parameter.new(true,:location, 'A')

  q = Query.new([p1,p2])
  puts es.calculate_scores([a,b],q).inspect
end