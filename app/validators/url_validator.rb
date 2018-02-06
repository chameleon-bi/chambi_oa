# Custom validator to validate URLs
class UrlValidator < ActiveModel::EachValidator
  # Validates URLs to include full protocol, subdomain, domain, TLD (or sTLD)
  def validate_each(record, attribute, value)
    unless value =~ URL_REGEX
      record.errors[attribute] << (options[:message] || 'is not a valid web address')
    end
    return nil if value.blank?
    record.errors[attribute] << 'must include http:// or https://' unless value.include?('http')
    record.errors[attribute] << 'cannot contain commas' if value.include?(',')
  end
end
