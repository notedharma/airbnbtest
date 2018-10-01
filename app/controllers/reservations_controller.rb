class ReservationsController < ApplicationController
  def index
  end

  def new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.user_id = current_user.id
    @reservation.listing_id = params[:listing_id]
    @reservation.save
    # @reservation.id
    redirect_to "/reservations/#{@reservation.id}/payment/new"
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def autoupdateprice
  end



    # post'/question/:question_id/answer/:answer_id/vote/:index' do
    #   if logged_in?
    #     Vote.add_answer_vote(params[:answer_id], current_user.id)
    #     count = Answer.includes(:votes).all.find_by_id(params[:answer_id]).votes.count
    #     {votecount: count, index:params[:index]}.to_json

    #   else
    #     p "Invalid Entry. Try Again."
    #   end











  private

    def reservation_params
      # convert date to right format, to string for params
      if params[:reservation][:checkin]
        params[:reservation][:checkin] = Date.strptime(params[:reservation][:checkin], '%m/%d/%Y').to_s
      end

      if params[:reservation][:checkout]
        params[:reservation][:checkout] = Date.strptime(params[:reservation][:checkout], '%m/%d/%Y').to_s
      end

      params.require(:reservation).permit(:checkin, :checkout, :listing_id)



    end
end
