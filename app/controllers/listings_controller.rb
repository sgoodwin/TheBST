class ListingsController < ApplicationController
  before_action :set_listing, only: %i[ sold cancel show edit update destroy ]

  def search
    @listings = Listing.search params[:q]

    respond_to do |format|
      format.html { render :index }
      format.json { render :index }
    end
  end

  def sold
    @listing.status = "sold"
    @listing.save

    redirect_to listing_url(@listing)
  end

  def cancel
    @listing.status = "cancelled"
    @listing.save

    redirect_to listing_url(@listing)
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
      redirect_to root_url
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
      redirect_to root_url
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

  # DELETE /listings/1 or /listings/1.json
  def destroy
    unless @listing.user == current_user
      redirect_to root_url
    else

      @listing.destroy

      respond_to do |format|
        format.html { redirect_to listings_url, notice: "Listing was successfully destroyed." }
        format.json { head :no_content }
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
