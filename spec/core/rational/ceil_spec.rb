require_relative "../../spec_helper"

describe "Rational#ceil" do
  before do
    @rational = Rational(2200, 7)
  end

  describe "with no arguments (precision = 0)" do
    it "returns an Integer" do
      @rational.ceil.should be_kind_of(Integer)
    end

    it "returns the truncated value toward positive infinity" do
      @rational.ceil.should == 315
      Rational(1, 2).ceil.should == 1
      Rational(-1, 2).ceil.should == 0
    end
  end

  describe "with a precision < 0" do
    it "returns an Integer" do
      NATFIXME 'Implement precision argument', exception: ArgumentError, message: 'wrong number of arguments' do
        @rational.ceil(-2).should be_kind_of(Integer)
        @rational.ceil(-1).should be_kind_of(Integer)
      end
    end

    it "moves the truncation point n decimal places left" do
      NATFIXME 'Implement precision argument', exception: ArgumentError, message: 'wrong number of arguments' do
        @rational.ceil(-3).should == 1000
        @rational.ceil(-2).should == 400
        @rational.ceil(-1).should == 320
      end
    end
  end

  describe "with precision > 0" do
    it "returns a Rational" do
      NATFIXME 'Implement precision argument', exception: ArgumentError, message: 'wrong number of arguments' do
        @rational.ceil(1).should be_kind_of(Rational)
        @rational.ceil(2).should be_kind_of(Rational)
      end
    end

    it "moves the truncation point n decimal places right" do
      NATFIXME 'Implement precision argument', exception: ArgumentError, message: 'wrong number of arguments' do
        @rational.ceil(1).should == Rational(3143, 10)
        @rational.ceil(2).should == Rational(31429, 100)
        @rational.ceil(3).should == Rational(157143, 500)
      end
    end
  end
end
