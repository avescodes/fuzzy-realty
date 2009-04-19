require 'stubs.rb'
require 'rulebase.rb'

module FuzzyRealty
  class ExpertSystem
    def self.scores(listings, query)
      
      scores = []
      
      for listing in listings
        score = 0
        query.params.each do |param|
          #calculate score modifier of parameter using indexed method
          change = FuzzyRealty::METHODS[param.type].call(listing,param)
          # if score is bad and parameter is required then reduce it further
          change = (change < 0.70 and param.required) ? (change - 1) : change
          
          score += change * FuzzyRealty::WEIGHTS[param.type]
        end
        scores << { :score => score, :listing => listing}
      end
      return scores.sort {|a,b| b[:score] <=> a[:score]}
    end
  end
end

if __FILE__ == $0
  listings = []
  10000.times do |i|
    listings << FuzzyRealty::Listing.new({
      :price => 20_000 + rand(250_000),
      :sqft => 300 + rand(2000),
      :location => %W{A B C D}[rand(4)],
      :style => %W{Bungalow Bi-level Split-level Two-story Condominium}[rand(5)]
    })
  end
  # The user wants price around 110k and in location A, 
  p1     = FuzzyRealty::Parameter.new(:price,250000)
  p2     = FuzzyRealty::Parameter.new(:location, 'A',true)
  p3     = FuzzyRealty::Parameter.new(:style,"Condominium",true)
  p4     = FuzzyRealty::Parameter.new(:sqft,1575,true)
  query  = FuzzyRealty::Query.new([p1,p2])
  scores = FuzzyRealty::ExpertSystem.scores(listings,query)
  scores.each do |score| 
    puts "%.2f" % score[:score] + "\t\t#{score[:listing].inspect}"
  end
end