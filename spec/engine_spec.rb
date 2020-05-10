require 'mini_exiftool'

describe Halation::Engine do
  subject { Halation::Engine.new(opts) }

  let(:opts) {{
    working_dir: working_dir,
    config_path: config_path,
    image_extensions: image_extensions,
    silent: true,
  }}

  let(:working_dir) { "spec/samples/set_1" }
  let(:config_path) { "#{working_dir}/config.yml" }
  let(:image_extensions) { ["tif"] }

  it { should respond_to :silent }
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

  describe do
    let(:samples_source) { "spec/samples/set_1" }
    let(:working_dir) { "spec/samples/under_test" }

    let(:artist) { "Me" }
    let(:copyright) { "2016 Me" }
    let(:make) { "Mamiya" }
    let(:model) { "Mamiya RZ67 Pro II" }
    let(:iso) { 100 }

    let(:exif_results) {[
      {
        # Frame 1
        "DateTimeOriginal" => Time.parse("2016-02-03 01:02:03"),
        "LensModel" => "Z180mm f/4.5W-N",
        "ExposureTime" => 1.0/250,
        "FNumber" => 8,
        "FocalLength" => 180,
        "Flash" => 0,
        "Orientation" => 1,
      },
      {
        # Frame 2
        "DateTimeOriginal" => Time.parse("2016-01-02"),
        "LensModel" => "Z100-200mm f/5.2W",
        "ExposureTime" => 0.5,
        "FNumber" => 8,
        "FocalLength" => 135,
        "Flash" => 1,
        "Orientation" => 6,
      },
      {
        # Frame 3
        "DateTimeOriginal" => Time.parse("2016-01-02"),
        "LensModel" => "Z110mm f/2.8W",
        "ExposureTime" => 1.0/250,
        "FNumber" => 8,
        "FocalLength" => 110,
        "Flash" => 0,
        "Orientation" => 1,
      },
      {
        # Frame 4
        "DateTimeOriginal" => Time.parse("2016-01-02"),
        "LensModel" => "Z110mm f/2.8W",
        "ExposureTime" => 1.0/250,
        "FNumber" => 8,
        "FocalLength" => 110,
        "Flash" => 0,
        "Orientation" => 1,
      },
      {
        # Frame 5
        "DateTimeOriginal" => Time.parse("2016-01-02"),
        "LensModel" => "Z110mm f/2.8W",
        "ExposureTime" => 1.0/250,
        "FNumber" => 8,
        "FocalLength" => 110,
        "Flash" => 0,
        "Orientation" => 1,
      },
      {
        # Frame 6
        "DateTimeOriginal" => Time.parse("2016-01-02"),
        "LensModel" => "Z110mm f/2.8W",
        "ExposureTime" => 1.0/250,
        "FNumber" => 8,
        "FocalLength" => 110,
        "Flash" => 0,
        "Orientation" => 1,
      },
      {
        # Frame 7
        "DateTimeOriginal" => Time.parse("2016-01-02"),
        "LensModel" => "Z110mm f/2.8W",
        "ExposureTime" => 1.0/250,
        "FNumber" => 8,
        "FocalLength" => 110,
        "Flash" => 0,
        "Orientation" => 1,
      },
      {
        # Frame 8
        "DateTimeOriginal" => Time.parse("2016-01-02"),
        "LensModel" => "Z110mm f/2.8W",
        "ExposureTime" => 1.0/250,
        "FNumber" => 8,
        "FocalLength" => 110,
        "Flash" => 0,
        "Orientation" => 1,
      },
      {
        # Frame 9
        "DateTimeOriginal" => Time.parse("2016-01-02"),
        "LensModel" => "Z110mm f/2.8W",
        "ExposureTime" => 1.0/250,
        "FNumber" => 8,
        "FocalLength" => 110,
        "Flash" => 0,
        "Orientation" => 1,
      },
      {
        # Frame 10
        "DateTimeOriginal" => Time.parse("2016-01-02"),
        "LensModel" => "Z110mm f/2.8W",
        "ExposureTime" => 1.0/250,
        "FNumber" => 8,
        "FocalLength" => 110,
        "Flash" => 0,
        "Orientation" => 1,
      },
    ]}

    before {
      FileUtils.rm_r(working_dir) if File.exists?(working_dir)
      FileUtils.cp_r(samples_source, working_dir)
    }

    after {
      FileUtils.rm_r(working_dir)
    }

    specify "run", is_long_running: true do
      subject.run

      Dir["#{working_dir}/*.tif"].sort.tap do |image_files|
        image_files.count.should eq 10

        image_files.each_with_index do |image_file, i|
          STDOUT.write(i + 1)

          MiniExiftool.new(image_file, numerical: true).tap do |exif|
            exif["Artist"].should eq artist
            exif["Copyright"].should eq copyright
            exif["DateTimeOriginal"].should eq exif_results[i]["DateTimeOriginal"]
            exif["CreateDate"].should eq exif_results[i]["DateTimeOriginal"]
            exif["Make"].should eq make
            exif["Model"].should eq model
            exif["ISO"].should eq iso
            exif["ExposureTime"].should eq exif_results[i]["ExposureTime"]
            exif["FNumber"].should eq exif_results[i]["FNumber"]
            exif["FocalLength"].should eq exif_results[i]["FocalLength"]
            exif["Flash"].should eq exif_results[i]["Flash"]
            exif["Orientation"].should eq exif_results[i]["Orientation"]
          end
        end
      end
    end

    specify "self.run" do
      engine_class = Halation::Engine
      engine_instance = Halation::Engine.new(opts)

      allow(engine_class).to receive(:new) { engine_instance }
      allow(engine_instance).to receive(:run)

      expect(engine_class).to receive(:new).with(opts)
      expect(engine_instance).to receive(:run).exactly(:once)

      Halation::Engine.run(opts)
    end
  end

end
