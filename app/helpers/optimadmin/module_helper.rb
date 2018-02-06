module Optimadmin
  module ModuleHelper
    def module_tooltip(tooltip_prompt_text, tooltip_content)
      content_tag :span, "#{tooltip_prompt_text} <span class='octicon octicon-question'></span>".html_safe, data: { tooltip: '', aria_haspopup: true }, class: 'has-tip', title: tooltip_content
    end

    def list_item(classes = 'large-1 small-4 text-center', &content)
      data = content_tag :div, class: "#{classes} columns" do
        capture(&content)
      end

      data
    end

    def render_object(object)
      if object.length >= 1
        render object
      else
        raw 'There are no results.'
      end
    end

    def pagination_helper(object, module_name)
      return unless object.length >= 1
      content_tag :div, (page_entries_info(object, entry_name: module_name) + '.'), class: 'pagination-information'
    end

    # http://stackoverflow.com/a/7830624
    def required?(obj, attribute)
      target = (obj.class == Class) ? obj : obj.class
      target.validators_on(attribute).map(&:class).include?(
        ActiveRecord::Validations::PresenceValidator)
    end
  end
end
