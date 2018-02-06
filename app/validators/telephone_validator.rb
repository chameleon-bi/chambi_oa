# Custom validator to validate telephones
class TelephoneValidator < ActiveModel::EachValidator
  # Validates telephones to include only numbers with spaces
  def validate_each(record, attribute, value)
    unless value =~ TELEPHONE_REGEX
      record.errors[attribute] << (options[:message] || 'is not a telephone (numbers and spaces only)')
    end
    return nil if value.blank?
  end
end
