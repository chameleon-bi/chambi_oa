# Custom validator to validate emails
class EmailValidator < ActiveModel::EachValidator
  # Validates email addresses, adding an error to the attribute if
  # it is not a valid email
  def validate_each(record, attribute, value)
    unless value =~ EMAIL_REGEX
      record.errors[attribute] << (options[:message] || 'is not an email')
    end
    return nil if value.blank?
    record.errors[attribute] << 'cannot contain commas' if value.include?(',')
  end
end
