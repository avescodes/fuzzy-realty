require 'test_helper'

class FuzzyRealtyTest < Test::Unit::TestCase
  
  context "Score verification" do
    setup do
      @listing = FuzzyRealty::Listing.new({
          :price => 250_000,
          :sqft => 1_575,
          :location => 'A',
          :style =>  'Condominium'
        })
    end
    
    should "score perfect for perfect house" do
      # The user wants price around 110k and in location A, 
      params = []
      params << FuzzyRealty::Parameter.new(:price,250_000,true)
      params << FuzzyRealty::Parameter.new(:location, 'A',true)
      params << FuzzyRealty::Parameter.new(:style,"Condominium",true)
      params << FuzzyRealty::Parameter.new(:sqft,1575,true)
      query  = FuzzyRealty::Query.new(params)

      scores = FuzzyRealty::ExpertSystem.scores([@listing],query)
      puts "%.2f" % scores[0][:score] + "\t\t#{scores[0][:listing].inspect}"
      assert_equal(scores[0][:score], FuzzyRealty.max_score)
    end
  end
  
end
