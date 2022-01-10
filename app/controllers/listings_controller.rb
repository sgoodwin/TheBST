class ListingsController < ApplicationController
  before_action :set_listing, only: %i[ mark show edit update ]
  before_action :not_if_banned

  def search
    @listings = Listing.search params[:q]

    respond_to do |format|
      format.html { render :index }
      format.json { render :index }
    end
  end

  # POST /mark/:id
  def mark
    unless @listing.allowed? current_user
      redirect_to listing_url(@listing)
    else

      status = params[:status]
      respond_to do |format|
        if Listing.statuses.include?(status) and
            @listing.status = status and
            @listing.save
          format.html { render :show, status: :accepted, listing: @listing }
          format.json { render :show, status: :accepted, location: @listing }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @listing.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # GET /listings or /listings.json
  def index
    @listings = Listing.active
  end

  # GET /listings/1 or /listings/1.json
  def show
  end

  # GET /listings/new
  def new
    @listing = Listing.new
  end

  # GET /listings/1/edit
  def edit
    unless @listing.allowed? current_user
      redirect_to listing_url(@listing)
    end
  end

  # POST /listings or /listings.json
  def create
    @listing = Listing.new(listing_params)
    @listing.user = current_user

    respond_to do |format|
      if @listing.save
        format.html { redirect_to listing_url(@listing), notice: "Listing was successfully created." }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1 or /listings/1.json
  def update
    unless @listing.allowed? current_user
      redirect_to edit_listing_url(@listing)
    else

      respond_to do |format|
        if @listing.update(listing_params)
          format.html { redirect_to listing_url(@listing), notice: "Listing was successfully updated." }
          format.json { render :show, status: :ok, location: @listing }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @listing.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_listing
    @listing = Listing.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def listing_params
    params.require(:listing).permit(:title, :info, :price, :currency)
  end

  def not_if_banned
    if current_user && current_user.banned?
      redirect_to root_url, alert: "You are banned until #{current_user.bans.last.end_at}"
    end
  end
end
