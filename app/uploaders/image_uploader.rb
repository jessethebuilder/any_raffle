# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    process :resize_to_fit => [100, 100]
  end

  version :large do
    process :resize_to_fit => [550, 550]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
