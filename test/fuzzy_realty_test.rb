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
      @listing = [@listing]
    end
    
    should "score perfect for perfect house" do
      # The user wants price around 110k and in location A, 
      params = []
      params << FuzzyRealty::Parameter.new(:price,250_000,true)
      params << FuzzyRealty::Parameter.new(:location, 'A',true)
      params << FuzzyRealty::Parameter.new(:style,"Condominium",true)
      params << FuzzyRealty::Parameter.new(:sqft,1575,true)
      query  = FuzzyRealty::Query.new(params)

      scores = FuzzyRealty::ExpertSystem.scores(@listing,query)
#      puts "%.2f" % scores[0][:score] + "\t\t#{scores[0][:listing].inspect}"
      assert_equal(scores[0][:score], FuzzyRealty.max_score)
    end
    
    should "score zero for no parameters" do
      params = []
      query = FuzzyRealty::Query.new(params)
      scores = FuzzyRealty::ExpertSystem.scores(@listing,query)
      assert_equal(scores[0][:score], 0)
    end
    
    context "for individual parameters" do
      should "score correctly for style" do
        params = []
        params << FuzzyRealty::Parameter.new(:style,"Condominium",true)
        query = FuzzyRealty::Query.new(params)
        scores = FuzzyRealty::ExpertSystem.scores(@listing,query)
        assert_equal(scores[0][:score], FuzzyRealty::WEIGHTS[:style])
      end
      should "score correctly for sqft" do
        params = []
        params << FuzzyRealty::Parameter.new(:sqft,1575,true)
        query = FuzzyRealty::Query.new(params)
        scores = FuzzyRealty::ExpertSystem.scores(@listing,query)
        assert_equal(scores[0][:score], FuzzyRealty::WEIGHTS[:sqft])
      end
      should "score correctly for price" do
        params = []
        params << FuzzyRealty::Parameter.new(:price,250_000,true)
        query = FuzzyRealty::Query.new(params)
        scores = FuzzyRealty::ExpertSystem.scores(@listing,query)
        assert_equal(scores[0][:score], FuzzyRealty::WEIGHTS[:price])
      end
      should "score correctly for location" do
        params = []
        params << FuzzyRealty::Parameter.new(:location, 'A',true)
        query = FuzzyRealty::Query.new(params)
        scores = FuzzyRealty::ExpertSystem.scores(@listing,query)
        assert_equal(scores[0][:score], FuzzyRealty::WEIGHTS[:location])
      end
    end
  end
  
end
