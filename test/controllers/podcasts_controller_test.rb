require 'test_helper'

class PodcastsControllerTest < ActionController::TestCase
  setup do
    @podcast = podcasts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:podcasts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create podcast" do
    assert_difference('Podcast.count') do
      post :create, podcast: { created_at: @podcast.created_at, description: @podcast.description, itunes_url: @podcast.itunes_url, soundcloud_url,: @podcast.soundcloud_url,, tags,: @podcast.tags,, title,: @podcast.title, }
    end

    assert_redirected_to podcast_path(assigns(:podcast))
  end

  test "should show podcast" do
    get :show, id: @podcast
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @podcast
    assert_response :success
  end

  test "should update podcast" do
    patch :update, id: @podcast, podcast: { created_at: @podcast.created_at, description: @podcast.description, itunes_url: @podcast.itunes_url, soundcloud_url,: @podcast.soundcloud_url,, tags,: @podcast.tags,, title,: @podcast.title, }
    assert_redirected_to podcast_path(assigns(:podcast))
  end

  test "should destroy podcast" do
    assert_difference('Podcast.count', -1) do
      delete :destroy, id: @podcast
    end

    assert_redirected_to podcasts_path
  end
end
