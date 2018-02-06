module Optimadmin
  module PresenterMethods
    attr_reader :object
    delegate :to_param, :to_partial_path, to: :object

    def self.included(base)
      base.extend(ClassMethods)
    end

    def initialize(object:, view_template:)
      @object = object
      @view_template = view_template
    end

    def id
      object.id
    end

    def edit_image(image, query_string_data = nil, query_string_value = nil)
      h.it_edit_images(image, query_string_data, query_string_value).call(object)
    end

    def view_link
      begin
        h.link_to eye, h.main_app.polymorphic_url(object), target: '_blank', class: 'menu-item-control'
      rescue
        ''
      end
    end

    def edit_link
      h.link_to pencil, h.polymorphic_url([:edit, object]), class: 'menu-item-control'
    end

    def delete_link
      h.link_to trash_can, h.polymorphic_url(object), method: :delete, data: { confirm: 'Are you sure?' }, class: 'menu-item-control'
    end

    def detail_toggle_link
      h.link_to(chevron_down, "#index-list-#{@object.id}", class: 'toggle-module-list-index helper-link', data: { container: "index-list-#{@object.id}", class: 'hide', return: 'true', this_class: 'octicon-chevron-up octicon-chevron-down' }) # if can?(:read, @object)
    end

    def inline_detail_toggle_link(content)
      h.link_to "#index-list-#{@object.id}", class: 'toggle-module-list-index helper-link', data: { container: "index-list-#{@object.id}", class: 'hide', return: 'true', this_class: 'octicon-chevron-up octicon-chevron-down' } do
        chevron_down + content
      end
      # if can?(:read, @object)
    end

    def toggle_link(attribute = :display)
      return nil unless object.respond_to?(attribute)
      h.link_to((object.send("#{attribute}?") ? 'Yes' : 'No'), h.toggle_path(model: object.class.name.demodulize, id: object.id, toggle: attribute), id: "#{attribute}-#{object.id}", class: "helper-link display #{ object.send("#{attribute}?") ? 'true' : 'false' }", remote: true)
    end

    def show_link

    end

    private

    def h
      @view_template
    end

    def disabled_delete_link
      h.content_tag :span, class: "disabled" do
        trash_can
      end
    end

    def disabled_show_link
      h.content_tag :span, class: "disabled" do
        eye
      end
    end

    def pencil
      octicon('pencil').html_safe
    end

    def trash_can
      octicon('trashcan').html_safe
    end

    def eye
      octicon('eye').html_safe
    end

    def chevron_down
      octicon('chevron-down').html_safe
    end

    def octicon(code)
      h.content_tag :span, '', class: "octicon octicon-#{code.to_s.dasherize}"
    end

    module ClassMethods
      def presents(name)
        define_method(name) do
          @object
        end
      end
    end
  end
end
