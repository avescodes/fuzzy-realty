require 'weights.rb'
require 'classes.rb'
require 'scores_table.rb'
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
  
  query  = FuzzyRealty::Query.new
  query << FuzzyRealty::Parameter.new(:price,250000)
  query << FuzzyRealty::Parameter.new(:location, 'A',true)
  query << FuzzyRealty::Parameter.new(:style,"Condominium",true)
  query << FuzzyRealty::Parameter.new(:sqft,1575,true)

  scores = FuzzyRealty::ExpertSystem.scores(listings,query)
  puts "Query 1, $250k Condominium in the prestiguous 'A' suburbs. 1575 sq. ft."
  puts "Top 20 Listings:"
  scores[(0..20)].each do |score| 
    puts "%.2f" % score[:score] + "\t\t#{score[:listing].inspect}"
  end
  
  puts "\n"
  query  = FuzzyRealty::Query.new
  query << FuzzyRealty::Parameter.new(:price,99_000,true)
  query << FuzzyRealty::Parameter.new(:location,'C')
  query << FuzzyRealty::Parameter.new(:style, "Bungalow")
  query << FuzzyRealty::Parameter.new(:sqft,1200)
  
  scores = FuzzyRealty::ExpertSystem.scores(listings,query)
  puts "Query 2, $99k Bungalow in the ever so average 'C' block. 1200 sq. ft."
  puts "Top 20 Listings:"
  scores[(0..20)].each do |score| 
    puts "%.2f" % score[:score] + "\t\t#{score[:listing].inspect}"
  end
end