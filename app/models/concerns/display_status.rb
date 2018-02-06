module DisplayStatus
  extend ActiveSupport::Concern

  included do
    validates :publish_at, presence: true
    validate :expire_after_publish, if: proc { |x| x.expire_at.present? }
  end

  module ClassMethods
    def published
      where("#{table_name}.publish_at <= :now AND (#{table_name}.expire_at IS NULL or #{table_name}.expire_at > :now)", now: Time.zone.now)
    end

    def scheduled
      where("#{table_name}.publish_at > :now", now: Time.zone.now)
    end

    def expired
      where("#{table_name}.expire_at <= :now", now: Time.zone.now)
    end
  end

  def expire_after_publish
    errors.add(:expire_at, 'must be after the publish date') if expire_at <= publish_at
  end
end
