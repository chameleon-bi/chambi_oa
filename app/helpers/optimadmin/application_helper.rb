module Optimadmin
  module ApplicationHelper
    # Return either thte link to preview the object or, or nil
    # See {http://api.rubyonrails.org/classes/ActionDispatch/Routing/PolymorphicRoutes.html} for more information
    #
    # @param object [ActiveRecord] the object for the edit link
    # @param content the content to be displayed
    # @return [ActionView::Helpers::UrlHelper]
    #
    # @example
    #   <%= detail_toggle_link(administrator) %>
    def detail_toggle_link(object:, content: octicon('chevron-down'))
      link_to(content, "#index-list-#{object.id}", class: 'toggle-module-list-index helper-link', data: { container: "index-list-#{object.id}", class: 'hide', return: 'true', this_class: 'octicon-chevron-up octicon-chevron-down' }) if can?(:read, object)
    end

    # Toggle display
    #
    # @param object [ActiveRecord] the object for the toggle link
    # @return [ActionView::Helpers::UrlHelper]
    #
    # @example
    #   <%= toggle_link(administrator) %>
    def toggle_link(object:, toggle: 'display')
      link_to((object.send(toggle) == true ? 'Yes' : 'No'), toggle_path(model: object.class.name.demodulize, id: object.id, toggle: toggle), id: "#{toggle}-#{object.id}", class: "helper-link display #{object.send(toggle) == true ? 'true' : 'false'}", remote: true) if can?(:update, object)
    end

    # Return either the edit link to the passed in object, or nil
    # See {http://api.rubyonrails.org/classes/ActionDispatch/Routing/PolymorphicRoutes.html} for more information
    #
    # @param object [ActiveRecord] the object for the edit link
    # @param content the content to be displayed
    # @return [ActionView::Helpers::UrlHelper]
    #
    # @example
    #   <%= edit_link(administrator) %>
    def edit_link(object:, content: octicon('pencil'))
      link_to(content, edit_polymorphic_path(object), class: 'helper-link') if can?(:update, object)
    end

    # Return either the show link to the passed in object, or nil
    #
    # @param object [ActiveRecord] the object for the show link
    # @param content the content to be displayed
    # @return [ActionView::Helpers::UrlHelper]
    #
    # @example
    #   <%= show_link(administrator) %>
    def show_link(object:, content: octicon('eye'))
      link_to(content, polymorphic_path(object), class: 'helper-link') if can?(:read, object)
    end

    # Return either the destroy link to the passed in object, or nil
    #
    # @param object [ActiveRecord] the object for the show link
    # @param content the content to be displayed
    # @return [ActionView::Helpers::UrlHelper]
    #
    # @example
    #   <%= show_link(administrator) %>
    def destroy_link(object:, content: octicon('trashcan'))
      link_to(content, polymorphic_path(object), class: 'helper-link', method: :delete, data: { confirm: 'Are you sure?' }) if can?(:destroy, object)
    end

    # Return link to the module or nil if administrator can access it
    #
    # @param Class [ActiveRecord]
    # @return [ActionView::Helpers::UrlHelper]
    #
    # @example
    # <%= module_link(module: Page, content: 'my link content')
    def module_link(content: nil, model:, path:)
      return nil unless can?(:read, model)
      content_tag :li do
        link_to (content || model.name.pluralize), path
      end
    end

    # Return an octicon
    #
    # @param string the code string as per https://octicons.github.com/
    # @return [ActionView::ContentTag]
    #
    # @example
    #   <%= octicon('arrow-right') %>
    def octicon(code)
      content_tag :span, '', class: "octicon octicon-#{code.to_s.dasherize}"
    end

    def colorbox_preview(image, title)
      link_to (image_tag image.image.thumb), image.image.url, class: 'single-colorbox', title: title
    end

    def active_class(path)
      'active' if current_page?(path)
    end

    # https://github.com/stefankroes/ancestry/wiki/Creating-a-selectbox-for-a-form-using-ancestry
    def ancestry_options(items, &block)
      return ancestry_options(items) { |i| "#{'-' * i.depth} #{i.name}" } unless block_given?
      result = []
      items.map do |item, sub_items|
        result << [yield(item), edit_menu_item_path(item.id)]
        # this is a recursive call:
        result += ancestry_options(sub_items, &block) if sub_items.present?
      end
      result
    end

    def closure_tree_select(items, &block)
      return closure_tree_select(items) { |i| "#{'-' * i.depth} #{i.name}" } unless block_given?
      result = []
      items.map do |item, sub_items|
        result << [yield(item), item.id]
        # this is a recursive call:
        result += closure_tree_select(sub_items, &block) if sub_items.present?
      end
      result
    end

    def it_edit_images(thumb_image = nil, query_string_data = nil, query_string_value = nil, options = {})
      lambda do |x|
        route_params = { id: x.id }
        route_params = route_params.merge({ ((query_string_data).to_sym) => query_string_value }) if query_string_data && query_string_value
        route_hash = polymorphic_path([:edit_images, x.class.name.underscore.singularize.downcase.gsub('/', '_')], route_params)

        # This may be a bit too heavy handed. If it becomes slow take it out.
        return nil if x.class.uploaders.keys.map { |y| x.send(y).path }.compact.blank? || thumb_image.nil? || x.send(thumb_image).path.blank?

        if x.send(thumb_image).thumb.present?
          link_to(image_tag(x.send(thumb_image).thumb), route_hash, options)
        else
          'File missing'
        end
      end
    end

    def media_edit_images(data = nil, image_name = nil, image_crop = nil, options = {}, route_options = {})
      lambda do |x|
        route_hash = { action: :edit_images, id: x.id }
        route_hash = route_hash.merge(route_options) if route_hash.present?
        route_hash['image_name'.to_sym] = image_name
        route_hash['image_crop'.to_sym] = image_crop
        link_to(data, route_hash, options) unless data.nil? || x.class.uploaders.keys.map { |y| x.send(y).path }.compact.blank?
      end
    end

    def cropper(object:, image_attr:)
      link_to cropping_path('Blah', object.id, image_attr, :thumb) do
        image_tag object.public_send(image_attr).public_send(:thumb).url
      end
    end

    def stored_images
      Optimadmin::Image.all
    end
  end
end
