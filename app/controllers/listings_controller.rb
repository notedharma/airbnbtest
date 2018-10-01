class ListingsController < ApplicationController
  def index


    @listings = Listing.all

    @listings = Listing.filter(filter_listings_params) if params[:search].present?

    @listings = @listings.order(:updated_at).page(params[:page]).per(12)
  end

  def new
  end

  def create
    @listing = Listing.new(listing_params)
    # @listing_id = @listing.id
    @listing.user_id = current_user.id
    @listing.save


    # render 'listings/show'


  end

  def show
    @listing = Listing.find(params[:id])
    @listing_imgs = @listing.images

    render 'listings/show'
    # @listing.user
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def update
    listing = Listing.find(params[:id])
    listing.update(listing_params)

    flash[:success] ="Successfully updated!"
    redirect_to edit_listing_path
  end

  private

    def listing_params
      params.require(:listing).permit(:title, :description, :address, :city, :country, :property_type, :beds, :max_guests, :price_night, {images: []})
    end

    def filter_listings_params
      params.require(:search).permit(:property_type, :city, :country, :min_price, :max_price)

    end
  end
