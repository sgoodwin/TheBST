require "test_helper"

class BanTest < ActiveSupport::TestCase

  test "banning a user" do
    user = users(:one)

    assert_difference "Ban.count" do
      user.ban!(1.week.from_now, "Posting porn instead of actual listings.")
    end

    assert user.banned?
  end

  test "previously banned users are no longer banned" do
    user = users(:two)

    user.ban!(1.week.ago, "Posting porn instead of actual listings.")

    assert !user.banned?
  end
end
