require 'test_helper'

class ApiControllerTest < ActionController::TestCase
  test "should get getAirports" do
    get :getAirports
    assert_response :success
  end

  test "should get getCOuntries" do
    get :getCOuntries
    assert_response :success
  end

end
