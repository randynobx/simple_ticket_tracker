class Ticket < ActiveRecord::Base
  belongs_to :account
  belongs_to :service
  has_many :records

  validates :id, presence: true, uniqueness: true
  validates :date, presence: true
  validates :account_id, presence: true, numericality: true
  validate :validate_account_id
  validates :service_id, presence: true, numericality: true
  validate :validate_service_id
  validates :materialscost, presence: true, numericality: true
  validates :labor, presence: true, numericality: true
  validates :total, presence: true, numericality: true
  validates :worklog, length: { maximum: 1000,
    too_long: "%{count} characters is the maximum allowed" }

  private
    def validate_account_id
      errors.add(:account_id, "is invalid") unless Account.exists?(self.account_id)
    end

    def validate_service_id
      errors.add(:service_id, "is invalid") unless Service.exists?(self.service_id)
    end
end
