# encoding: utf-8

class AttachmentUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end


  version :preview do
    process :resize_to_fit => [700, 400]
  end


end
