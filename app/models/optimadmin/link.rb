module Optimadmin
  class Link < ActiveRecord::Base
    has_one :menu_item
    belongs_to :menu_resource, polymorphic: true
    validates :menu_resource_type, :menu_resource_id, presence: true

    def self.related_menu_items(module_page_name, menu_name)
      module_page_id = ModulePage.find_by(name: module_page_name)
      return unless module_page_id.present?

      object = Link.joins(:menu_item).where('menu_resource_type = ? and menu_resource_id = ? AND optimadmin_menu_items.menu_name = ?', Optimadmin::ModulePage, module_page_id, menu_name)

      if object.present? && object.first.menu_item.root?
        object.first.menu_item.self_and_descendants.hash_tree
      elsif object.present? && object.first.menu_item.child?
        object.first.menu_item.parent.self_and_descendants.hash_tree
      else
        []
      end
    end
  end
end
