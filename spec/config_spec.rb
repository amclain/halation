describe Halation::Config do
  let(:config_file) { "spec/samples/set_1/config.yml" }

  shared_examples "test for default values" do
    it "has default values" do
      subject.artist.should be nil
      subject.copyright.should be nil
      subject.cameras.should eq []
    end
  end

  describe "initializes default values" do
    include_examples "test for default values"
  end

  describe "with loaded config file" do
    subject {
      Halation::Config.new.tap do |config|
        config.load_file(config_file)
      end
    }

    it "has values" do
      subject.artist.should eq "Test Artist"
      subject.copyright.should eq "2016 Test Artist"

      cameras = subject.cameras
      cameras.count.should eq 1
      
      cameras.first.tap do |camera|
        camera.tag.should eq "rz67"
        camera.make.should eq "Mamiya"
        camera.model.should eq "Mamiya RZ67 Pro II"

        lenses = camera.lenses
        lenses.count.should eq 2

        lenses.each_with_index do |lens, i|
          case i
          when 0
            lens.tag.should eq "110"
            lens.model.should eq "Z110mm f/2.8W"
            lens.focal_length.should eq 110
          when 1
            lens.tag.should eq "180"
            lens.model.should eq "Z180mm f/4.5W-N"
            lens.focal_length.should eq 180
          end
        end
      end
    end

    describe "#reset reinitializes default values" do
      before { subject.reset }

      include_examples "test for default values"
    end
  end
end
