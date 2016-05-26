describe Halation::Config::Lens do
  let(:tag) { 110 }
  let(:model) { "Z110mm f/2.8W" }
  let(:focal_length) { 110 }

  let(:yaml) {{
    "tag" => tag,
    "model" => model,
    "focal_length" => focal_length,
  }}

  subject { Halation::Config::Lens.new(yaml) }

  its(:tag) { should eq tag.to_s }
  its(:model) { should eq model.to_s }
  its(:focal_length) { should eq focal_length.to_i }

  shared_examples :to_s_is_human_readable
end
