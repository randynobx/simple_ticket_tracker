class Service < ActiveRecord::Base
	has_many :tickets

	validates :id, presence: true, uniqueness: true
	validates :category, presence: true
	validates :price, presence: true, numericality: true
	validates :rate, presence: true
end
