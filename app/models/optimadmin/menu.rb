module Optimadmin
  class Menu
    attr_reader :name

    def initialize(name:)
      @name = name
    end

    def humanized_name
      name.humanize
    end

    def menu_items(show_all: false)
      # TODO: Remove !(Optimadmin::MenuItem.column_names.include? 'display') when rolled out to all sites
      if show_all.present? || !(Optimadmin::MenuItem.column_names.include? 'display')
        @menu_items ||= MenuItem.includes(link: :menu_resource).where(menu_name: name).hash_tree
      else
        @menu_items ||= MenuItem.includes(link: :menu_resource).where("menu_name = ? AND display = ?", name, true).hash_tree
      end
    end

    def root_menu_item?(object)
      MenuItem.includes(link: :menu_resource).joins(:link).where(optimadmin_links: { menu_resource_id: object.id, menu_resource_type: object.class.name }).first.link.menu_item.root?
    end

    def root_menu_items(object)
      MenuItem.includes(link: :menu_resource).joins(:link).where(optimadmin_links: { menu_resource_id: object.id, menu_resource_type: object.class.name }).first.link.menu_item.root.hash_tree
    end

    def has_children?(object)
      MenuItem.includes(link: :menu_resource).joins(:link).where(optimadmin_links: { menu_resource_id: object.id, menu_resource_type: object.class.name }).first.link.menu_item.children.present?
    end

    def related_menu_items(object)
      # FIXME there is probably a better way to do this
      if root_menu_item? object
        @menu_items ||= MenuItem.includes(link: :menu_resource).joins(:link).where(optimadmin_links: { menu_resource_id: object.id, menu_resource_type: object.class.name }).first.link.menu_item.self_and_descendants.hash_tree
      else
        @menu_items ||= MenuItem.includes(link: :menu_resource).joins(:link).where(optimadmin_links: { menu_resource_id: object.id, menu_resource_type: object.class.name }).first.link.menu_item.parent.self_and_descendants.hash_tree
      end

      @menu_items
    end

    def child_menu_items(object)
      # FIXME there is probably a better way to do this
      menu_items = MenuItem.includes(link: :menu_resource).joins(:link).where(optimadmin_links: { menu_resource_id: object.id, menu_resource_type: object.class.name })
      return nil if menu_items.nil?
      menu_items.first.link.menu_item.descendants
    end

    def parent_menu_items(object)
      # FIXME there is probably a better way to do this
      menu_items = MenuItem.includes(link: :menu_resource).joins(:link).where(optimadmin_links: { menu_resource_id: object.id, menu_resource_type: object.class.name })
      return nil if menu_items.nil?
      menu_items.first.link.menu_item.self_and_ancestors
    end

    def sibling_menu_items(object)
      # FIXME there is probably a better way to do this
      menu_items = MenuItem.includes(link: :menu_resource).joins(:link).where(optimadmin_links: { menu_resource_id: object.id, menu_resource_type: object.class.name })
      return nil if menu_items.nil?
      menu_items.first.link.menu_item.parent.descendants
    end

    def self.build_collection
      NavigationMenus.map do |navigation_menu|
        Menu.new(name: navigation_menu)
      end
    end
  end
end
