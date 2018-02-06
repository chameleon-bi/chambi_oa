module Optimadmin
  class Image < ActiveRecord::Base
    mount_uploader :image, ImageUploader

    validates :name, :image, presence: true

    def self.search(keywords)
      if keywords.present?
        where('name ILIKE ?', "%#{keywords}%").order(created_at: :desc)
      else
        order(created_at: :desc)
      end
    end

    def path
      image.path
    end

    def size
      (image.size.to_f / 1000).round(2)
    end

    def url
      image.url
    end

    def thumb
      image.thumb
    end

    def self.store_image(optimadmin_module, optimadmin_module_image)
      image_name = "#{optimadmin_module.title || optimadmin_module.name || optimadmin_module.headline} - #{optimadmin_module_image.filename}"
      image = new(name: image_name,
                  module_name: optimadmin_module.class.name,
                  module_id: optimadmin_module.id,
                  image: optimadmin_module_image)
      image.save
    end
  end
end
