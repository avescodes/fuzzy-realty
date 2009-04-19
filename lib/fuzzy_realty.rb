require 'stubs.rb'
require 'scores_table.rb'
require 'weights.rb'
require 'rulebase.rb'
require 'rulebase.rb'

# If set this flag will turn on debugging printouts
#$debug = true;

module FuzzyRealty
  class ExpertSystem
    def self.scores(listings, query)
      
      scores = []
      
      for listing in listings
        score = 0
        query.params.each do |param|
          #calculate score modifier of parameter using indexed method
          change = FuzzyRealty::RULES[param.type].call(listing,param.desired)
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

#When running the library directly calculate an example
if __FILE__ == $0
  listings = []
  100.times do |i|
    listings << FuzzyRealty::Listing.new({
      :price => 20_000 + rand(250_000),
      :sqft => 300 + rand(2000),
      :location => %W{A B C D}[rand(4)],
      :style => %W{Bungalow Bi-level Split-level Two-story Condominium}[rand(5)]
    })
  end
  
  parameters = []
  parameters << FuzzyRealty::Parameter.new(:price,250000)
  parameters << FuzzyRealty::Parameter.new(:location, 'A',true)
  parameters << FuzzyRealty::Parameter.new(:style,"Condominium",true)
  parameters << FuzzyRealty::Parameter.new(:sqft,1575,true)
  query  = FuzzyRealty::Query.new(parameters)
  scores = FuzzyRealty::ExpertSystem.scores(listings,query)
  scores.each do |score| 
    puts "%.2f" % score[:score] + "\t\t#{score[:listing].inspect}"
  end
end