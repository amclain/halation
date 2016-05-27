describe Halation::Engine do
  subject {
    Halation::Engine.new(
      working_dir: working_dir,
      config_path: config_path,
      image_extensions: image_extensions
    )
  }

  let(:working_dir) { "spec/samples/set_1" }
  let(:config_path) { "#{working_dir}/config.yml" }
  let(:image_extensions) { ["tif"] }

  its(:image_extensions) { should eq image_extensions }

  specify "image_files" do
    subject.image_files.tap do |image_files|
      image_files.count.should eq 10

      (1..10)
        .map { |i| "#{working_dir}/#{i.to_s.rjust(2, "0")}.#{image_extensions.first}"}
        .each_with_index do |expected_file, i|
          image_files[i].end_with?(expected_file).should eq true
      end
    end
  end

  specify "run"
end
