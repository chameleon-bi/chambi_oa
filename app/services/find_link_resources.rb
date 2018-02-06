class FindLinkResources
  attr_reader :klass

  def initialize(klass)
    @klass = klass.constantize
  rescue NameError
    @klass = nil
  end

  def call
    return nil if klass.nil?

    if klass.first.respond_to?(:custom_menu_item_name)
      klass.all.map { |x| [x.custom_menu_item_name, x.id] }
    elsif klass.column_names.include?('name')
      klass.pluck(:name, :id)
    elsif klass.column_names.include?('title')
      klass.pluck(:title, :id)
    elsif klass.column_names.include?('headline')
      klass.pluck(:headline, :id)
    end
  end

  def tiny_mce
    return nil if klass.nil?
    klass.all
  end
end
