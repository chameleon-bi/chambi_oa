module OptimadminScopes
  extend ActiveSupport::Concern

  included do
    before_save :set_position, if: proc { |x| x.has_attribute?('position') && x.position.nil? }

    def set_position
      self.position = self.class.all.order(:position).reject { |x| x.position.blank? }.last.position + 1
    rescue
      self.position = 1
    end
  end

  module ClassMethods
    def field_order(order)
      order.present? ? unscoped.order(order) : all
    end

    def field_search(query, field = 'title')
      if query.present? && field.is_a?(Array)
        joined_where_query(query, field)
      elsif query.present?
        where("#{field} ILIKE ?", "%#{query}%")
      else
        all
      end
    end

    def pagination(page, per_page = 15)
      per_page = 15 if per_page.blank?
      page(page).per(per_page.to_i)
    end

    private

    def joined_where_query(query, field)
      search_query = ''
      field.each do |field_type|
        search_query += "#{field_type} ILIKE :query "
        search_query += ' OR ' unless field_type == field.last
      end
      where(search_query, query: "%#{query}%")
    end
  end
end
