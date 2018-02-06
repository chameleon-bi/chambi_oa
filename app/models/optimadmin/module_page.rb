module Optimadmin
  class ModulePage < ActiveRecord::Base
    has_many :menu_items, as: :menu_resource
    validates :name, :route, presence: true, uniqueness: { case_sensitive: false }

    def child_menu_items(object)
      # FIXME: there is probably a better way to do this
      menu_items = MenuItem.includes(link: :menu_resource).joins(:link).where(optimadmin_links: { menu_resource_id: object.id, menu_resource_type: object.class.name })
      return nil if menu_items.nil?
      menu_items.first.link.menu_item.descendants
    end

    def root_menu_item?(object)
      MenuItem.includes(link: :menu_resource).joins(:link).where(optimadmin_links: { menu_resource_id: object.id, menu_resource_type: object.class.name }).first.link.menu_item.root?
    end

    def related_menu_items(object)
      # FIXME: there is probably a better way to do this
      if root_menu_item? object
        @menu_items ||= MenuItem.includes(link: :menu_resource).joins(:link).where(optimadmin_links: { menu_resource_id: object.id, menu_resource_type: object.class.name }).first.link.menu_item.self_and_descendants.hash_tree
      else
        @menu_items ||= MenuItem.includes(link: :menu_resource).joins(:link).where(optimadmin_links: { menu_resource_id: object.id, menu_resource_type: object.class.name }).first.link.menu_item.parent.self_and_descendants.hash_tree
      end

      @menu_items
    end
  end
end
