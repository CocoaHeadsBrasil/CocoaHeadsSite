require 'test_helper'

class FaqGroupsControllerTest < ActionController::TestCase
  setup do
    @faq_group = faq_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:faq_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create faq_group" do
    assert_difference('FaqGroup.count') do
      post :create, faq_group: { position: @faq_group.position, published: @faq_group.published, title: @faq_group.title }
    end

    assert_redirected_to faq_group_path(assigns(:faq_group))
  end

  test "should show faq_group" do
    get :show, id: @faq_group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @faq_group
    assert_response :success
  end

  test "should update faq_group" do
    patch :update, id: @faq_group, faq_group: { position: @faq_group.position, published: @faq_group.published, title: @faq_group.title }
    assert_redirected_to faq_group_path(assigns(:faq_group))
  end

  test "should destroy faq_group" do
    assert_difference('FaqGroup.count', -1) do
      delete :destroy, id: @faq_group
    end

    assert_redirected_to faq_groups_path
  end
end
