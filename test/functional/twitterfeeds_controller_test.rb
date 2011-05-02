require 'test_helper'

class TwitterfeedsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:twitterfeeds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create twitterfeed" do
    assert_difference('Twitterfeed.count') do
      post :create, :twitterfeed => { }
    end

    assert_redirected_to twitterfeed_path(assigns(:twitterfeed))
  end

  test "should show twitterfeed" do
    get :show, :id => twitterfeeds(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => twitterfeeds(:one).id
    assert_response :success
  end

  test "should update twitterfeed" do
    put :update, :id => twitterfeeds(:one).id, :twitterfeed => { }
    assert_redirected_to twitterfeed_path(assigns(:twitterfeed))
  end

  test "should destroy twitterfeed" do
    assert_difference('Twitterfeed.count', -1) do
      delete :destroy, :id => twitterfeeds(:one).id
    end

    assert_redirected_to twitterfeeds_path
  end
end
