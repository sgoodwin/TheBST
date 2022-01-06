require "test_helper"
require "helpers/login"

class ListingsControllerTest < ActionDispatch::IntegrationTest
  include LoginHelper

  setup do
    @listing = listings(:one)
  end

  test "should get index" do
    get listings_url
    assert_response :success
  end

  test "should get new" do
    get new_listing_url
    assert_response :success
  end

  test "should create listing" do
    login users(:one)
    assert_difference("Listing.count") do
      post listings_url, params: { listing: { currency: @listing.currency, info: @listing.info, price: @listing.price, title: @listing.title } }
    end

    assert_redirected_to listing_url(Listing.last)
  end

  test "should show listing" do
    get listing_url(@listing)
    assert_response :success
  end

  test "should get edit" do
    login users(:one)
    get edit_listing_url(@listing)
    assert_response :success
  end

  test "should update listing" do
    login users(:one)
    patch listing_url(@listing), params: { listing: { currency: @listing.currency, info: @listing.info, price: @listing.price, title: @listing.title } }
    assert_redirected_to listing_url(@listing)
  end

  test "should destroy listing" do
    login users(:one)
    assert_difference("Listing.count", -1) do
      delete listing_url(@listing)
    end

    assert_redirected_to listings_url
  end
end
