class ListingsController < ApplicationController
  before_action :set_listing, only: %i[ sold cancel show edit update ]

  def search
    @listings = Listing.search params[:q]

    respond_to do |format|
      format.html { render :index }
      format.json { render :index }
    end
  end

  # POST /mark_as_sold/:id
  def sold
    @listing.status = "sold"
    @listing.save

    render :show, status: :accepted, listing: @listing
  end

  # POST /mark_as_cancelled/:id
  def cancel
    @listing.status = "cancelled"
    @listing.save

    render :show, status: :accepted, listing: @listing
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
    unless @listing.user == current_user
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

    unless @listing.user == current_user
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
end
