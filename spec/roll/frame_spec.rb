describe Halation::Roll::Frame do
  let(:yaml) {{
    "number" => number,
    "date" => date,
    "lens" => lens,
    "focal_length" => focal_length,
    "shutter" => shutter,
    "aperture" => aperture,
    "flash" => flash,
    "orientation" => orientation,
  }}

  subject { Halation::Roll::Frame.new(yaml) }

  shared_examples "frame" do
    its(:number) { should eq number.to_i }
    its(:date) { should eq date.to_s }
    its(:lens) { should eq lens.to_s }
    its(:focal_length) { should eq focal_length && focal_length.to_i }
    its(:shutter) { should eq shutter.to_s }
    its(:aperture) { should eq aperture.to_s }
    its(:flash) { should eq !!flash }
    its(:orientation) { should eq 0 } # Not yet implemented
  end

  describe "prime lens" do
    let(:number) { 1 }
    let(:date) { "2016-01-02" }
    let(:lens) { 180 }
    let(:focal_length) { nil }
    let(:shutter) { 250 }
    let(:aperture) { 8 }
    let(:flash) { false }
    let(:orientation) { 0 }

    include_examples "frame"
  end

  describe "zoom lens" do
    let(:number) { 1 }
    let(:date) { "2016-01-02" }
    let(:lens) { "100-200" }
    let(:focal_length) { 135 }
    let(:shutter) { 250 }
    let(:aperture) { 8 }
    let(:flash) { true }
    let(:orientation) { 0 }

    include_examples "frame"
  end

end
