class ReservationMailer < ApplicationMailer
  def reservation_email(reservation)


    # @guest = reservation.user
    # @host = reservation.listing.user
    # @listing = reservation.listing
    @reservation = reservation
    @nights = (@reservation.checkout - @reservation.checkin).to_i

    mail(to: @reservation.user.email, subject: "You're going to #{@reservation.listing.city}!")
  end
end
