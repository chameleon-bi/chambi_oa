module Optimadmin
  class Document < ActiveRecord::Base
    mount_uploader :document, DocumentUploader

    validates :name, :document, presence: true

    def path
      document.path
    end

    def size
      (document.size.to_f / 1000).round(2)
    end

    def url
      document.url
    end

    def self.store_file(optimadmin_module, optimadmin_module_document)
      document_name = "#{optimadmin_module.title || optimadmin_module.name || optimadmin_module.headline} - #{optimadmin_module_document.filename}"
      document = new(name: document_name,
                     module_name: optimadmin_module.class.name,
                     module_id: optimadmin_module.id,
                     document: optimadmin_module_document)
      document.save
    end
  end
end
