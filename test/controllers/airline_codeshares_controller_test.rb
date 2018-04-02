require 'test_helper'

class AirlineCodesharesControllerTest < ActionController::TestCase
  setup do
    @airline_codeshare = airline_codeshares(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:airline_codeshares)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create airline_codeshare" do
    assert_difference('AirlineCodeshare.count') do
      post :create, airline_codeshare: { aircompany_id: @airline_codeshare.aircompany_id, code_share_finish: @airline_codeshare.code_share_finish, code_share_start: @airline_codeshare.code_share_start, codeshare_id: @airline_codeshare.codeshare_id }
    end

    assert_redirected_to airline_codeshare_path(assigns(:airline_codeshare))
  end

  test "should show airline_codeshare" do
    get :show, id: @airline_codeshare
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @airline_codeshare
    assert_response :success
  end

  test "should update airline_codeshare" do
    patch :update, id: @airline_codeshare, airline_codeshare: { aircompany_id: @airline_codeshare.aircompany_id, code_share_finish: @airline_codeshare.code_share_finish, code_share_start: @airline_codeshare.code_share_start, codeshare_id: @airline_codeshare.codeshare_id }
    assert_redirected_to airline_codeshare_path(assigns(:airline_codeshare))
  end

  test "should destroy airline_codeshare" do
    assert_difference('AirlineCodeshare.count', -1) do
      delete :destroy, id: @airline_codeshare
    end

    assert_redirected_to airline_codeshares_path
  end
end
