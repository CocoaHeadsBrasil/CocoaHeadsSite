# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

  include CarrierWaveDirect::Uploader
  include CarrierWave::MiniMagick

  include ActiveModel::Conversion
  extend ActiveModel::Naming

  # include CarrierWave::MimeTypes
  # process :extension_white_list

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Create different versions of your uploaded files:
  version :thumb do
    process :resize_to_limit => [200, 200]
  end

end
