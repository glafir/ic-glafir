require 'test_helper'

class TownsControllerTest < ActionController::TestCase
  setup do
    @town = towns(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:towns)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create town" do
    assert_difference('Town.count') do
      post :create, town: { accent_city: @town.accent_city, city: @town.city, country: @town.country, latitude: @town.latitude, longitude: @town.longitude, region: @town.region }
    end

    assert_redirected_to town_path(assigns(:town))
  end

  test "should show town" do
    get :show, id: @town
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @town
    assert_response :success
  end

  test "should update town" do
    put :update, id: @town, town: { accent_city: @town.accent_city, city: @town.city, country: @town.country, latitude: @town.latitude, longitude: @town.longitude, region: @town.region }
    assert_redirected_to town_path(assigns(:town))
  end

  test "should destroy town" do
    assert_difference('Town.count', -1) do
      delete :destroy, id: @town
    end

    assert_redirected_to towns_path
  end
end
