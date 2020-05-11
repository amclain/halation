describe Halation::Roll::Frame do
  let(:yaml) {{
    "number" => number,
    "date_captured" => date_captured,
    "date_scanned" => date_scanned,
    "lens" => lens,
    "focal_length" => focal_length,
    "shutter" => shutter,
    "aperture" => aperture,
    "flash" => flash,
    "orientation" => orientation,
  }}

  subject { Halation::Roll::Frame.new(yaml) }

  shared_examples :frame do
    its(:number) { should eq number.to_i }
    its(:date_captured) { should eq Time.parse(date_captured) }
    its(:date_scanned) { should eq Time.parse(date_scanned) }
    its(:lens) { should eq lens.to_s }
    its(:focal_length) { should eq focal_length && focal_length.to_i }
    its(:shutter) { should eq shutter.to_s }
    its(:aperture) { should eq aperture.to_s }
    its(:flash) { should eq !!flash }
    its(:orientation) { should eq orientation }
  end

  describe "prime lens" do
    let(:number) { 1 }
    let(:date_captured) { "2016-01-02" }
    let(:date_scanned) { "2016-01-15" }
    let(:lens) { 180 }
    let(:focal_length) { nil }
    let(:shutter) { 250 }
    let(:aperture) { 8 }
    let(:flash) { false }
    let(:orientation) { 1 }

    include_examples :frame
  end

  describe "zoom lens" do
    let(:number) { 1 }
    let(:date_captured) { "2016-01-02" }
    let(:date_scanned) { "2016-01-15" }
    let(:lens) { "100-200" }
    let(:focal_length) { 135 }
    let(:shutter) { 250 }
    let(:aperture) { 8 }
    let(:flash) { true }
    let(:orientation) { 1 }

    include_examples :frame
  end

end
