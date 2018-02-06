module Optimadmin
  class MenuItem < ActiveRecord::Base
    has_closure_tree order: 'position', dependent: :delete_all

    validates :menu_name, presence: true, length: { maximum: 100 }
    validates :name, presence: true, length: { maximum: 100 }
    validates :title_attribute, length: { maximum: 100 }

    belongs_to :link, class_name: 'Optimadmin::Link', dependent: :destroy

    accepts_nested_attributes_for :link

    before_create :set_position
    before_save :check_title_attr
    after_save :display_attribute
    before_destroy :check_last_external_link

    def self.presenter
      MenuItemPresenter
    end

    def set_position
      last_position = MenuItem.order(:position).last
      self.position = last_position.position + 1 unless MenuItem.count == 0
    end

    def check_title_attr
      self.title_attribute = name if title_attribute.blank? || name_was == title_attribute
    end

    def check_last_external_link
      return unless link.menu_resource_type == 'Optimadmin::ExternalLink'

      # FIXME: this needs tidying maybe?
      results = Optimadmin::Link.where(menu_resource_type: 'Optimadmin::ExternalLink', menu_resource_id: link.menu_resource_id)
      Optimadmin::ExternalLink.destroy(results.first.menu_resource_id) if results.size == 1
    end

    def display_attribute
      # TODO: Remove !(Optimadmin::MenuItem.column_names.include? 'display') when rolled out to all sites
      return unless display_changed? || !(Optimadmin::MenuItem.column_names.include? 'display')
      # Set parents to display, if they're hidden, this is a descendant and set to display
      ancestors.update_all(display: display) if ancestors.present? && display == true
      # Set descendants to display, if they're hidden, this is a parent and set to display
      descendants.update_all(display: display) if descendants.present?
    end
  end
end
