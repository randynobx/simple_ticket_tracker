class Account < ActiveRecord::Base
	has_many :tickets
	has_many :records
	
	validates :id, presence: true, uniqueness: true
	validates :category, presence: true
	validates :name, presence: true,
                length: { minimum: 3 }
  validates :notes, length: { maximum: 1000,
    			too_long: "%{count} characters is the maximum allowed" }
  validates :address, length: { maximum: 20,
          too_long: "%{count} characters is the maximum allowed" }
  validates :city, length: { maximum: 20,
          too_long: "%{count} characters is the maximum allowed" }
  validates :state, length: { maximum: 2,
          too_long: "%{count} characters is the maximum allowed" }
  validates :zip, length: { maximum: 5,
          too_long: "%{count} characters is the maximum allowed" }
  validates :email, :allow_blank => true, :format => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

end
