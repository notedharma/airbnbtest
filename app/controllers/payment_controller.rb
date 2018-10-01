class PaymentController < ApplicationController
  def new

    @client_token = Braintree::ClientToken.generate

    # define reservation for checkout messages
    @reservation = Reservation.find(params[:id])
    @nights = (@reservation.checkout - @reservation.checkin).to_i

  end

  def checkout
    nonce_from_the_client = params[:checkout_form][:payment_method_nonce]

    # define reservation to get price
    @reservation = Reservation.find(params[:id])

    result = Braintree::Transaction.sale(
      # insert price here!
      :amount => @reservation.price,
      :payment_method_nonce => nonce_from_the_client,
      :options => {
        :submit_for_settlement => true
      }
    )

    if result.success?
      @reservation = Reservation.find(params[:id])
      redirect_to reservation_path, :flash => { :success => "Transaction successful!" }
      # Send email to activejob que via sidekiq. use _now to bypass que
      # you need to make three terminals and execute rails s, redis-server, and bundle exec sidekiq -q default -q mailers
       ReservationJob.perform_later(@reservation)
    else
      redirect_to :root, :flash => { :error => "Transaction failed. Please try again." }
    end
  end
end
