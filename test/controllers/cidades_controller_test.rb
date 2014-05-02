require 'test_helper'

class CidadesControllerTest < ActionController::TestCase
  setup do
    @cidade = cidades(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cidades)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cidade" do
    assert_difference('Cidade.count') do
      post :create, cidade: { cidade: @cidade.cidade, estado: @cidade.estado, facebook: @cidade.facebook, github: @cidade.github, organizador: @cidade.organizador, organizador_email: @cidade.organizador_email, published: @cidade.published, twitter: @cidade.twitter, website: @cidade.website }
    end

    assert_redirected_to cidade_path(assigns(:cidade))
  end

  test "should show cidade" do
    get :show, id: @cidade
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cidade
    assert_response :success
  end

  test "should update cidade" do
    patch :update, id: @cidade, cidade: { cidade: @cidade.cidade, estado: @cidade.estado, facebook: @cidade.facebook, github: @cidade.github, organizador: @cidade.organizador, organizador_email: @cidade.organizador_email, published: @cidade.published, twitter: @cidade.twitter, website: @cidade.website }
    assert_redirected_to cidade_path(assigns(:cidade))
  end

  test "should destroy cidade" do
    assert_difference('Cidade.count', -1) do
      delete :destroy, id: @cidade
    end

    assert_redirected_to cidades_path
  end
end
