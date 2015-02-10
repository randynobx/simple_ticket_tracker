class Record < ActiveRecord::Base
  belongs_to :account
  belongs_to :ticket

  validates :id, presence: true, uniqueness: true
  validates :date, presence: true
  validates :account_id, presence: true, numericality: true
  validate :validate_account_id
  validates :ticket_id, presence: true, numericality: true
  validate :validate_ticket_id
  validates :income, presence: true, numericality: true
  validates :expense, presence: true, numericality: true
  validates :total, presence: true, numericality: true
  validates :notes, length: { maximum: 1000,
    			too_long: "%{count} characters is the maximum allowed" }

  private
    def validate_account_id
      errors.add(:account_id, "is invalid") unless Account.exists?(self.account_id)
    end

    def validate_ticket_id
      errors.add(:ticket_id, "is invalid") unless Ticket.exists?(self.ticket_id)
    end
  end
