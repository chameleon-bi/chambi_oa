module Optimadmin
  class DocumentUploader < CarrierWave::Uploader::Base
    storage :file

    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

    def self.extension_white_list
      %w(3ds ai csv doc docx dwg dxf igs indd odp ods odt pdf ppt ppsx potx pptx psd rtf swf txt xls xlt xlsx xltx zip mp3) + Optimadmin::ImageUploader.extension_white_list
    end

    def extension_white_list
      self.class.extension_white_list
    end
  end
end
