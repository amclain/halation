describe Halation::Config::Camera do
  let(:tag) { "rz67" }
  let(:make) { "Mamiya" }
  let(:model) { "Mamiya RZ67 Pro II" }

  let(:lens_tag) { "110" }
  let(:lens_model) { "Z110mm f/2.8W" }
  let(:lens_focal_length) { 110 }

  let(:lens) {{
    "tag" => lens_tag,
    "model" => lens_model,
    "focal_length" => lens_focal_length,
  }}

  let(:yaml) {{
    "tag" => tag,
    "make" => make,
    "model" => model,
    "lenses" => [lens],
  }}

  subject { Halation::Config::Camera.new(yaml) }

  its(:tag) { should eq tag.to_s }
  its(:make) { should eq make.to_s }
  its(:model) { should eq model.to_s }

  it "contains the lens" do
    subject.lenses.count.should eq 1
    
    subject.lenses.first.tap do |lens|
      lens.tag.should eq lens_tag
      lens.model.should eq lens_model
      lens.focal_length.should eq lens_focal_length
    end
  end
end
