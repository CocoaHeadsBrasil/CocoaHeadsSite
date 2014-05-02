require 'test_helper'

class AgendasControllerTest < ActionController::TestCase
  setup do
    @agenda = agendas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:agendas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create agenda" do
    assert_difference('Agenda.count') do
      post :create, agenda: { descricao: @agenda.descricao, horario: @agenda.horario, local: @agenda.local, maps: @agenda.maps, passbook: @agenda.passbook, published: @agenda.published }
    end

    assert_redirected_to agenda_path(assigns(:agenda))
  end

  test "should show agenda" do
    get :show, id: @agenda
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @agenda
    assert_response :success
  end

  test "should update agenda" do
    patch :update, id: @agenda, agenda: { descricao: @agenda.descricao, horario: @agenda.horario, local: @agenda.local, maps: @agenda.maps, passbook: @agenda.passbook, published: @agenda.published }
    assert_redirected_to agenda_path(assigns(:agenda))
  end

  test "should destroy agenda" do
    assert_difference('Agenda.count', -1) do
      delete :destroy, id: @agenda
    end

    assert_redirected_to agendas_path
  end
end
