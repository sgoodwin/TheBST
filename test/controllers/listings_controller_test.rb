require "test_helper"
require "helpers/login"

class ListingsControllerTest < ActionDispatch::IntegrationTest
  include LoginHelper

  setup do
    @listing = listings(:one)
    users(:admin).add_role :admin
    users(:banned).ban!(1.week.from_now, "They trolled")
  end

  test "should get index" do
    get listings_url
    assert_response :success
  end

  test "should search listings" do
    get search_url "Info", format: :html
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

  test "should not create invalid listings" do
    login users(:one)
    assert_no_difference("Listing.count") do
      post listings_url, params: { listing: { currency: @listing.currency, info: @listing.info, price: -1, title: @listing.title } }
    end

    assert_response :unprocessable_entity
  end

  test "banned users should not create listings" do
    login users(:banned)
    assert_no_difference("Listing.count") do
      post listings_url, params: { listing: { currency: @listing.currency, info: @listing.info, price: 11, title: @listing.title } }
    end

    assert_redirected_to root_url
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

  test "should not get edit for other listings" do
    login users(:two)
    get edit_listing_url(@listing)
    assert_redirected_to listing_url(@listing)
  end

  test "admins should get edit for other listings" do
    login users(:admin)
    get edit_listing_url(@listing)
    assert_response :success
  end

  test "should update listing" do
    login users(:one)
    patch listing_url(@listing), params: { listing: { currency: @listing.currency, info: @listing.info, price: @listing.price, title: @listing.title } }
    assert_redirected_to listing_url(@listing)
  end

  test "should not update listing with invalid values" do
    login users(:one)
    patch listing_url(@listing), params: { listing: { currency: @listing.currency, info: @listing.info, price: -10, title: @listing.title } }
    assert_response 422
  end

  test "should not update other people's listings" do
    login users(:two)
    patch listing_url(@listing), params: { listing: { currency: @listing.currency, info: @listing.info, price: 10, title: @listing.title } }
    assert_redirected_to edit_listing_url(@listing)
  end

  test "admins should update other people's listings" do
    login users(:admin)
    patch listing_url(@listing), params: { listing: { currency: @listing.currency, info: @listing.info, price: 10, title: @listing.title } }
    assert_redirected_to listing_url(@listing)
  end

  test "mark a listing as sold" do
    login users(:one)
    assert_difference("Listing.sold.count") do
      post mark_url(listings(:two)), params: { status: :sold }
    end
    assert_response :success
  end

  test "mark a listing as cancelled" do
    login users(:one)
    assert_difference("Listing.cancelled.count") do
      post mark_url(@listing), params: { status: :cancelled }
    end
    assert_response :success
  end

  test "mark a listing as active" do
    login users(:one)
    assert_difference("Listing.active.count") do
      post mark_url(listings(:sold)), params: { status: :active }
    end
    assert_response :success
  end

  test "mark a listing with an invalid status" do
    login users(:one)
    assert_no_difference("Listing.active.count") do
      post mark_url(listings(:sold)), params: { status: :poop }
    end
    assert_response :unprocessable_entity
  end

  test "other users can't mark listings" do
    login users(:two)
    assert_no_difference("Listing.active.count") do
      post mark_url(@listing), params: { status: :sold }
    end
    assert_redirected_to listing_url(@listing)
  end

  test "admins can mark listings" do
    login users(:admin)
    assert_difference("Listing.sold.count") do
      post mark_url(listings(:two)), params: { status: :sold }
    end
    assert_response :success
  end
end
