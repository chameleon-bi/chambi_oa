module Optimadmin
  class BasePresenter
    attr_reader :object
    delegate :to_param, :to_partial_path, to: :object

    def initialize(object:, view_template:)
      @object = object
      @view_template = view_template
    end

    def self.presents(name)
      define_method(name) do
        @object
      end
    end

    def edit_link
      h.link_to pencil, h.polymorphic_url([:edit, @object]), class: 'menu-item-control'
    end

    def delete_link
      h.link_to trash_can, h.polymorphic_url(@object), method: :delete, data: { confirm: 'Are you sure?' }, class: 'menu-item-control'
    end

    private

    def h
      @view_template
    end

    def disabled_delete_link
      h.content_tag :span, trash_can, class: 'disabled'
    end

    def disabled_show_link
      h.content_tag :span, eye, class: 'disabled'
    end

    def pencil
      h.octicon('pencil').html_safe
    end

    def trash_can
      h.octicon('trashcan').html_safe
    end

    def eye
      h.octicon('eye').html_safe
    end
  end
end
