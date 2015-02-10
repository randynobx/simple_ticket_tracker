require 'test_helper'

class TicketsControllerTest < ActionController::TestCase
  ### Helper functions ###

  setup :initialize_ticket

  def teardown
  	@ticket = nil
  end

  ### Function Tests ###

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tickets)
  end

  test "should show ticket" do
  	get :show, id: @ticket.id
  	assert_response :success
  end

  test "should successfully create" do
  	assert_difference('Ticket.count') do
      post :create, ticket: {id: 20, date: "2015-01-03", account_id: 0, service_id: 0, materialscost: 0.00, labor: 50.00, total: 50.00, closed: true, worklog: "Notes"}
  	end
 
  	assert_redirected_to ticket_path(assigns(:ticket))
  end

  test "should successfully update" do
  	worklog = "Test worklog here."
  	patch :update, id: @ticket.id, ticket: { worklog: worklog }
  	assert_redirected_to ticket_path(assigns(:ticket))
  	@ticket.reload
  	assert_equal @ticket.worklog, worklog
  end

  test "unsuccessful edit" do
  	get :edit, id: @ticket.id
  	assert_template 'tickets/edit', locals: { id: @ticket.id }
  	assert_raises(ActiveRecord::RecordInvalid) { patch :update, id: @ticket.id, ticket: { service_id: 999 } }
  	assert_template
  end

  test "should destroy ticket" do
  	assert_difference('Ticket.count', -1) do
      delete :destroy, id: @ticket.id
  	end
 
  	assert_redirected_to tickets_path
  end

  ### Routing tests ###

  test "should route to ticket" do
    assert_routing '/tickets/0', { controller: "tickets", action: "show", id: "0" }
  end

  test "should route to create ticket" do
  	assert_routing({ method: 'post', path: '/tickets' }, { controller: "tickets", action: "create" })
  end

  test "should route to edit ticket" do
    assert_routing({ method: 'patch', path: '/tickets/0' }, { controller: "tickets", action: "update", id: "0" })
  end

  test "should route to destroy ticket" do
    assert_routing({ method: 'delete', path: '/tickets/0' }, { controller: "tickets", action: "destroy", id: "0" })
  end

  ### Layout tests ###

  test "index should render correct layout" do
  	get :index
  	assert_template :index
  	assert_template layout: "layouts/application"
  end

  test "show should render correct layout" do
  	get :show, id: @ticket.id
  	assert_template :show, locals: { id: @ticket.id }
  	assert_template layout: "layouts/application"
  end

  test "new should render correct layout" do
  	get :new
  	assert_template :new
  	assert_template layout: "layouts/application", partial: "_form"
  end

  test "edit should render correct layout" do
  	get :edit, id: @ticket.id
  	assert_template :edit, locals: { id: @ticket.id }
  	assert_template layout: "layouts/application", partial: "_form"
  end

  ### Exception Tests ###

  test "show should reroute to ticket not found" do
    assert_raises(RuntimeError) { get :show, id: 999 }
  end

  test "edit should throw not found exception" do
    assert_raises(RuntimeError) { get :edit, id: 999 }
  end

  test "destroy should throw not found exception" do
    assert_raises(RuntimeError) { delete :destroy, id: 999 }
  end

  private
  	def initialize_ticket
  	  @ticket = tickets(:one)
  	end
end