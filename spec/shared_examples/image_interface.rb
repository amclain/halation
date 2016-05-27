shared_examples :image_interface do
  [
    # Save the image file.
    :save,
    # Read an Exif tag.
    :[],
    # Write an Exif tag.
    :[]=,
  ].each do |sym|
    it { should respond_to sym }
  end
end
