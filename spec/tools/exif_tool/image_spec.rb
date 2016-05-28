require 'mini_exiftool'

describe Halation::ExifToolImage do
  subject { Halation::ExifToolImage.new(image_path) }

  let(:samples_path) { "spec/samples/set_1" }
  let(:image_path) { "#{samples_path}/01.tif" }

  include_examples :image_interface

  describe do
    before {
      FileUtils.cp("#{samples_path}/01.tif", image_path)
    }

    after {
      File.delete(image_path) if File.exists?(image_path)
    }

    let(:image_path) { "#{samples_path}/under-test.tif" }
    let(:tag) { :iso }
    let(:tag_value_1) { 100 }
    let(:tag_value_2) { 400 }

    it "reads and writes a tag", is_long_running: true do
      Halation::ExifToolImage.new(image_path).tap do |subject|
        subject[tag] = tag_value_1
        subject.save
      end

      MiniExiftool.new(image_path).tap do |image|
        image[tag].should eq tag_value_1
        image[tag] = tag_value_2
        image.save
      end

      Halation::ExifToolImage.new(image_path).tap do |subject|
        subject[tag].should eq tag_value_2
      end
    end
  end
end
