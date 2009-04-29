require 'rubygems'
require 'ruby-prof'
require 'fuzzy_realty.rb'

if __FILE__ == $0
RubyProf.start

puts "Generating 10000 Listings"
listings = []
10000.times do |i|
  listings << FuzzyRealty::Listing.random
end


query  = FuzzyRealty::Query.new
query << FuzzyRealty::Parameter.new(:price,250000)
query << FuzzyRealty::Parameter.new(:location, 'A',true)
query << FuzzyRealty::Parameter.new(:style,"Condominium",true)
query << FuzzyRealty::Parameter.new(:sqft,1575,true)

puts "Running score calculation 10 times..."
scores = []
10.times { |i| puts i; scores = FuzzyRealty::ExpertSystem.scores(listings,query) }
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

puts "Running score calculation 10 times..."
10.times { |i| puts i; scores = FuzzyRealty::ExpertSystem.scores(listings,query) }
puts "Query 2, $99k Bungalow in the ever so average 'C' block. 1200 sq. ft."
puts "Top 20 Listings:"
scores[(0..20)].each do |score| 
 puts "%.2f" % score[:score] + "\t\t#{score[:listing].inspect}"
end

result = RubyProf.stop

printer = RubyProf::GraphHtmlPrinter.new(result)
printer.print(STDOUT, :min_percent=>0)
end
