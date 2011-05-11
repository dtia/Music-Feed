require 'test_helper'

class YoutubevideosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:youtubevideos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create youtubevideo" do
    assert_difference('Youtubevideo.count') do
      post :create, :youtubevideo => { }
    end

    assert_redirected_to youtubevideo_path(assigns(:youtubevideo))
  end

  test "should show youtubevideo" do
    get :show, :id => youtubevideos(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => youtubevideos(:one).id
    assert_response :success
  end

  test "should update youtubevideo" do
    put :update, :id => youtubevideos(:one).id, :youtubevideo => { }
    assert_redirected_to youtubevideo_path(assigns(:youtubevideo))
  end

  test "should destroy youtubevideo" do
    assert_difference('Youtubevideo.count', -1) do
      delete :destroy, :id => youtubevideos(:one).id
    end

    assert_redirected_to youtubevideos_path
  end
end
