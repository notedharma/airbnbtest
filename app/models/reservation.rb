class Reservation < ApplicationRecord
	belongs_to :user
	belongs_to :listing

	validates :checkin, presence: true
	validates :checkout, presence: true

	validate :check_dates
	validate :check_before_today
	validate :check_overlap

	before_create :compute_price

	def check_dates
		# validate not before today
		if self.checkin > self.checkout
			errors.add(:date_error, "Invalid Dates")
		end
	end

	def check_before_today
		if self.checkin < Date.today
			errors.add(:date_error, "Invalid Checkin Day")
		end
	end

	def check_overlap
		current_reservations = Reservation.where(listing_id: self.listing_id)
		start_date = self.checkin
		end_date = self.checkout
		current_reservations.each do |x|
			if (start_date..end_date).overlaps?(x.checkin..x.checkout)
					errors.add(:date_error, "Already reserved. Choose other dates")
			end
		end
	end
	
	def compute_price

		listing_price = Listing.find(self.listing_id).price_night
		self.price = (self.checkout - self.checkin) * listing_price

	end
end


