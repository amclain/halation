describe Halation::Config do
  let(:config_file) { "spec/samples/set_1/config.yml" }

  shared_examples "test for default values" do
    it "has default values" do
      subject.artist.should be nil
      subject.copyright.should be nil
      subject.cameras.should eq []
    end
  end

  it "has a default config path" do
    Halation::Config::DEFAULT_CONFIG_PATH.should be_kind_of String
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

    let(:artist) { "Test Artist" }
    let(:copyright) { "2016 Test Artist" }

    let(:cameras) {[
      {
        tag: "rz67",
        make: "Mamiya",
        model: "Mamiya RZ67 Pro II",
        lenses: [
          { tag: "110", model: "Z110mm f/2.8W", focal_length: 110 },
          { tag: "180", model: "Z180mm f/4.5W-N", focal_length: 180 },
          { tag: "100-200", model: "Z100-200mm f/5.2W", focal_length: nil }
        ]
      }
    ]}

    it "has values" do
      subject.artist.should eq artist
      subject.copyright.should eq copyright

      subject.cameras.count.should eq cameras.count
      
      subject.cameras.each_with_index do |camera, i|
        camera.tag.should eq cameras[i][:tag]
        camera.make.should eq cameras[i][:make]
        camera.model.should eq cameras[i][:model]

        camera.lenses.count.should eq cameras[i][:lenses].count

        camera.lenses.each_with_index do |lens, j|
          lens.tag.should eq cameras[i][:lenses][j][:tag]
          lens.model.should eq cameras[i][:lenses][j][:model]
          lens.focal_length.should eq cameras[i][:lenses][j][:focal_length]
        end
      end
    end

    describe "#reset reinitializes default values" do
      before { subject.reset }

      include_examples "test for default values"
    end

    include_examples :to_s_is_human_readable
  end
end
