class AvatarUploader < CarrierWave::Uploader::Base

  # Choose what kind of storage to use for this uploader:
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end


  def extension_allowlist
    %w(gif png)
    # %w(jpg jpeg gif png)
  end

  # def content_type_allowlist
  #   %w[/image\//]
  # end
  
  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
