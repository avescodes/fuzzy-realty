require 'fuzzy_realty.rb'

puts "Benchmarking search through 100,000-1 (powers of ten) random listings"
puts "======================================================================="
listings = []
100_000.times { listings << FuzzyRealty::Listing.random }
puts "Generated #{listings.count} random listings"
Benchmark.bm do |x|
  x.report("100,000 listings:") { FuzzyRealty::ExpertSystem.scores(listings,Query.random) }
  listings = listings[(0...10_000)]
  x.report("10,000 listings:") { FuzzyRealty::ExpertSystem.scores(listings,Query.random) }
  listings = listings[(0...1_000)]
  x.report("1,000 listings:") { FuzzyRealty::ExpertSystem.scores(listings,Query.random) }
  listings = listings[(0...100)]
  x.report("100 listings:") { FuzzyRealty::ExpertSystem.scores(listings,Query.random) }
  listings = listings[(0...10)]
  x.report("10 listings:") { FuzzyRealty::ExpertSystem.scores(listings,Query.random) }
  listings = listings[(0...1)]
  x.report("1 listing:") { FuzzyRealty::ExpertSystem.scores(listings,Query.random) }
end
