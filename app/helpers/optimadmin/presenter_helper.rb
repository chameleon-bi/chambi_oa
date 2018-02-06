module Optimadmin
  module PresenterHelper
    def nested_admin_menu_items(menu_items:, depth: 1)
      menu_items.map do |menu_item, sub_menu_items|
        render partial: 'optimadmin/menu_items/menu_item',
               locals: { menu_item_presenter: Optimadmin::MenuItemPresenter.new(object: menu_item, view_template: self),
                         sub_menu_items: sub_menu_items, depth: depth }
      end.join.html_safe
    end

    def present(object, klass = nil)
       klass ||= "Optimadmin::#{ object.class }Presenter".constantize
       presenter = klass.new(object: object, view_template: self)
       yield presenter if block_given?
       presenter
    end
  end
end
