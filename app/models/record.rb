class Record < ActiveRecord::Base
  belongs_to :account
  belongs_to :ticket

  validates :id, presence: true, uniqueness: true
  validates :account_id, presence: true
  validates :ticket_id, presence: true
  validates :income, presence: true, numericality: true
  validates :expense, presence: true, numericality: true
  validates :total, presence: true, numericality: true
  validates :notes, length: { maximum: 1000,
    			too_long: "%{count} characters is the maximum allowed" }
  end
