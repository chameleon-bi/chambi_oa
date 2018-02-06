module Optimadmin
  class ImageUploader < ImageDefaultsUploader
    process resize_to_limit: [1500, 1500]
  end
end
