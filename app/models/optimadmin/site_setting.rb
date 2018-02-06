module Optimadmin
  class SiteSetting < ActiveRecord::Base
    validates :value, presence: true
    validates :key, uniqueness: { scope: :environment }, presence: true

    before_save :set_environment, if: proc { |ss| ss.environment.blank? }

    def self.current_environment
      Hash[where(environment: Rails.env.to_s).pluck(:key, :value)]
    end

    private

    def set_environment
      self.environment = Rails.env.to_s
    end
  end
end
