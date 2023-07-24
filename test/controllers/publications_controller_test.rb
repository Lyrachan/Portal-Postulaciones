require 'test_helper'

class PublicationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @publication = publications(:one)
    sign_in(users(:two)) # Iniciando con rol de usuario normal
  end

  test "should get index" do
    get publications_url
    assert_response :success
  end

  test "should get new" do
    # sign_in (:one)
    get new_publication_url
    assert_response :success
  end

  test "should create publication" do
    assert_difference("Publication.count") do
      post publications_url, params:
      { publication: {
        name: @publication.name,
          description: @publication.description
          }}
    end

    assert_redirected_to publication_url(Publication.last)
  end

  test "should show publication" do
    get publication_url(@publication)
    assert_response :success
  end

  test "should get edit" do
    get edit_publication_url(@publication)
    assert_response :success
  end

  test "should update publication" do
    patch publication_url(@publication), params: { publication: { description: @publication.description, name: @publication.name } }
    assert_redirected_to publication_url(@publication)
  end

  test "should destroy publication" do
    assert_difference("Publication.count", -1) do
      delete publication_url(@publication)
    end
    assert_redirected_to publications_url
  end

  # PRUEBA UNITARIA PARA INGRESAR UNA POSTULACIÓN COMO USUARIO

  test "should create postulation" do
    # El inicio de sesión del usuario común está en el setup
    get publication_url(@publication)
    assert_response :success
    # Aquí se está referiendo con PublicationsUser a la tabla intermedia
    assert_difference("PublicationsUser.count") do
      # Como es una tabla intermedia, sólo se pasan los parámetros del usuario y publicación, en vez de crear contenido para ésta
      # Me hubiera complicado menos la vida si la hubiera hecho sin has_and_belongs_to_many :(
      post new_user_postulation_url, params:
      { user_id: users(:two).id,
      publication_id: @publication.id
      }
    end
    assert_redirected_to publication_url(@publication)
  end
end
