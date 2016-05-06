describe Halation::Coerce do
  Coerce = Halation::Coerce

  describe "a string" do
    specify "from a string" do
      Coerce.string("test").should eq "test"
    end

    specify "from a symbol" do
      Coerce.string(:test).should eq "test"
    end

    specify "from an integer" do
      Coerce.string(100).should eq "100"
    end

    specify "from nil" do
      Coerce.string(nil).should be nil
    end
  end

  describe "an integer" do
    specify "from an integer" do
      Coerce.integer(100).should eq 100
    end

    specify "from a string" do
      Coerce.integer("150").should eq 150
    end

    specify "from nil" do
      Coerce.integer(nil).should be nil
    end
  end
end
