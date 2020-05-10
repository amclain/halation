describe Halation::Roll do
  let(:config_file) { "spec/samples/set_1/roll.yml" }

  shared_examples :test_for_default_values do
    it "has default values" do
      subject.artist.should be nil
      subject.copyright.should be nil
      subject.date_captured.should be nil
      subject.camera.should be nil
      subject.lens.should be nil
      subject.iso.should be nil
      subject.frames.should eq []
    end
  end

  describe "initializes default values" do
    include_examples :test_for_default_values
  end

  describe "with loaded config file" do
    subject {
      Halation::Roll.new.tap do |config|
        config.load_file(config_file)
      end
    }

    it "has values" do
      subject.artist.should eq "Me"
      subject.copyright.should eq "2016 Me"
      subject.date_captured.should eq Time.parse("2016-01-02")
      subject.camera.should eq "rz67"
      subject.lens.should eq "110"
      subject.iso.should eq 100

      frames = subject.frames
      frames.count.should eq 10
      
      frames.each_with_index do |frame, i|
        case i
        when 0
          frame.number.should eq 1
          frame.date_captured.should eq Time.parse("2016-02-03 01:02:03")
          frame.lens.should eq "180"
          frame.focal_length.should be nil
          frame.shutter.should eq "1/250"
          frame.aperture.should eq "8"
          frame.flash.should eq false
          frame.orientation.should eq 1
        when 1
          frame.number.should eq 2
          frame.date_captured.should be nil
          frame.lens.should eq "100-200"
          frame.focal_length.should eq 135
          frame.shutter.should eq "0.5"
          frame.aperture.should eq "8"
          frame.flash.should eq true
          frame.orientation.should eq 6
        when 2
          frame.number.should eq 3
          frame.date_captured.should be nil
          frame.lens.should be nil
          frame.focal_length.should be nil
          frame.shutter.should eq "1/250"
          frame.aperture.should eq "8"
          frame.flash.should eq false
          frame.orientation.should be nil
        end
      end
    end

    describe "#reset reinitializes default values" do
      before { subject.reset }

      include_examples :test_for_default_values
    end
  end
end
