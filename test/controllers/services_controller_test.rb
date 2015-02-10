require 'test_helper'

class ServicesControllerTest < ActionController::TestCase
  ### Helper functions ###

  setup :initialize_service
  
  def teardown
  	@service = nil
  end
  
  ### Function Tests ###

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:services)
  end

  test "should show service" do
  	get :show, id: @service.id
  	assert_response :success
  end

  test "should successfully create" do
  	assert_difference('Service.count') do
      post :create, service: {id: 20, category: "Test service 200", price: 15.00, rate: "Hourly"}
  	end
 
  	assert_redirected_to service_path(assigns(:service))
  end

  test "should successfully update" do
  	rate = "Hourly"
  	patch :update, id: @service.id, service: { rate: rate }
  	assert_redirected_to service_path(assigns(:service))
  	@service.reload
  	assert_equal @service.rate, rate
  end

  test "unsuccessful edit" do
  	get :edit, id: @service.id
  	assert_template 'services/edit', locals: { id: @service.id }
  	assert_raises(ActiveRecord::RecordInvalid) { patch :update, id: @service.id, service: { price: "bad" } }
  	assert_template
  end

  ### Routing tests ###

  test "should route to service" do
    assert_routing '/services/0', { controller: "services", action: "show", id: "0" }
  end

  test "should route to create service" do
  	assert_routing({ method: 'post', path: '/services' }, { controller: "services", action: "create" })
  end

  test "should route to edit service" do
    assert_routing({ method: 'patch', path: '/services/0' }, { controller: "services", action: "update", id: "0" })
  end

  ### Layout tests ###

  test "index should render correct layout" do
  	get :index
  	assert_template :index
  	assert_template layout: "layouts/application"
  end

  test "show should render correct layout" do
  	get :show, id: @service.id
  	assert_template :show, locals: { id: @service.id }
  	assert_template layout: "layouts/application"
  end

  test "new should render correct layout" do
  	get :new
  	assert_template :new
  	assert_template layout: "layouts/application", partial: "_form"
  end

  test "edit should render correct layout" do
  	get :edit, id: @service.id
  	assert_template :edit, locals: { id: @service.id }
  	assert_template layout: "layouts/application", partial: "_form"
  end

  ### Exception Tests ###

  test "show should reroute to service not found" do
    assert_raises(RuntimeError) { get :show, id: 999 }
  end

  test "edit should throw not found exception" do
    assert_raises(RuntimeError) { get :edit, id: 999 }
  end

  private
  	def initialize_service
  	  @service = services(:service1)
  	end
end
