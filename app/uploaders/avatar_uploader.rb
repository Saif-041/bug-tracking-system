# frozen_string_literal: true

# This class AvatarUploader < CarrierWave
class AvatarUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_allowlist
    %w[gif png]
  end
end
