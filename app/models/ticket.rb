class Ticket < ActiveRecord::Base
  belongs_to :account
  belongs_to :service
  has_many :records

  validates :id, presence: true, uniqueness: true
  validates :date, presence: true
  validates :account_id, presence: true
  validates :service_id, presence: true
  validates :materialscost, presence: true, numericality: true
  validates :labor, presence: true, numericality: true
  validates :total, presence: true, numericality: true
  validates :worklog, length: { maximum: 1000,
    too_long: "%{count} characters is the maximum allowed" }
end
