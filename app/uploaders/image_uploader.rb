class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file
  process resize_to_fit: [200, 200]

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
  process :scale => [25 , 25]
end

def scale(width, height)

end

end
