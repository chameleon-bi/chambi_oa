class MenuItemDestinationEvaluator

  attr_reader :menu_resource

  def initialize(view_template:, menu_resource:, admin: false)
    @view_template = view_template
    @menu_resource = menu_resource
    @admin = admin
  end

  def admin?
    @admin
  end

  def destination
    case menu_resource
      when Optimadmin::ModulePage
        module_page_route
      when Optimadmin::ExternalLink
        menu_resource.name
      else
        if menu_resource.class.method_defined? :custom_path
          menu_resource.custom_path
        elsif visible?(menu_resource)
          menu_resource
        end
    end
  end

  def tinymce_destination
    case menu_resource
      when Optimadmin::ModulePage
        module_page_route
      when Optimadmin::ExternalLink
        menu_resource.name
      else
        begin
          h.main_app.polymorphic_url(menu_resource).gsub("#{h.main_app.root_url}", '/') if visible?(menu_resource)
        rescue
          ''
        end
    end
  end

  def active?
    h.current_page?(destination)
  end

  private

  def visible?(menu_resource)
    return nil if menu_resource.blank?
    if menu_resource.has_attribute?('display') && menu_resource.display == true
      true
    elsif menu_resource.has_attribute?('publish_at') && menu_resource.has_attribute?('expire_at') && menu_resource.publish_at <= Time.zone.now && (menu_resource.expire_at.blank? || (menu_resource.expire_at.present? && menu_resource.expire_at > Time.zone.now))
      true
    else
      false
    end
  end

  def module_page_route
    if admin?
      h.main_app.public_send(menu_resource.route)  if h.main_app.respond_to?(menu_resource.route)
    else
      h.public_send(menu_resource.route) if h.respond_to?(menu_resource.route)
    end
  end

  def h
    @view_template
  end

end
