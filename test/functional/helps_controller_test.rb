require 'test_helper'

class HelpsControllerTest < ActionController::TestCase
  def setup
    user = create :user
    sign_in user
    @help = create :help
    @params = {id: @help.id}
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show, @params
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should post create" do
    @params[:help] = attributes_for(:help)
    post :create, @params
    assert_response :success
  end

  test "should get edit" do
    get :edit, @params
    assert_response :success
  end

  test "should put update" do
    @params[:help] = attributes_for(:help)
    put :update, @params
    assert_response :redirect
  end

  test "should delete destroy" do
    delete :destroy, @params
    assert_response :redirect
  end
end
