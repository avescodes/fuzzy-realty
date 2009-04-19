module FuzzyRealty
  # Table for looking up score of relative locations
  # 
  # A is a high-class suburb
  # B is a middle-class area
  # C is an older middle-class area
  # D is a "ghetto"
  #   A    B      C   D
  # A 1.0  0.75  0.2  0.0
  # B 0.75 1.00  0.4  0.1
  # C 0.2  0.4   1.0  0.6
  # D 0.0  0.1   0.6  1.0  
  LOCN = {
    :A => {:A => 1.0,  :B => 0.75, :C => 0.2, :D => 0.0}, 
    :B => {:A => 0.75, :B => 1.0,  :C => 0.4, :D => 0.1},
    :C => {:A => 0.2,  :B => 0.4,  :C => 1.0, :D => 0.6},
    :D => {:A => 0.0,  :B => 0.1,  :C => 0.6, :D => 1.0}
  }

  # Table for lookup of score of desired and actual styles
  # - Arbitrary values provied by my wife, at present the leanings aren't quite right
  #
  # Bu = Bungalow, Bi = Bilevel, Sp = Splitlevel, Tw = Two Story, Co = Condo
  #|    |   Bu |  Sp |  Tw |   Bi |  Co |
  #| Bu |    1 | 0.4 | 0.8 | 0.65 | 0.1 |
  #| Sp |  0.5 |   1 | 0.7 | 0.95 | 0.2 |
  #| Tw |  0.0 | 0.6 |   1 |  0.5 | 0.0 |
  #| Bi | 0.75 | 0.6 | 0.8 |    1 | 0.0 |
  #| Co |  0.7 | 0.0 | 0.0 |  0.0 |   1 |  
  STYLE = {
    :Symbol => {"Bungalow" => :Bu, "Bi-level" => :Bi, "Split-level" => :Sp,
                "Two-story" => :Tw, "Condominium" => :Co},
    :Bu => { :Bu => 1,   :Sp => 0.4, :Tw => 0.8, :Bi => 0.65, :Co => 0.1 },
    :Sp => { :Bu => 0.5, :Sp => 1.0, :Tw => 0.7, :Bi => 0.95, :Co => 0.2 },
    :Tw => { :Bu => 0.0, :Sp => 0.6, :Tw => 1.0, :Bi => 0.5,  :Co => 0.0 },
    :Bi => { :Bu => 0.75,:Sp => 0.6, :Tw => 0.8, :Bi => 1.0,  :Co => 0.0 },
    :Co => { :Bu => 0.7, :Sp => 0.0, :Tw => 0.0, :Bi => 0.0,  :Co => 1.0 }
  }
end