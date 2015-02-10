require 'test_helper'

class RecordsControllerTest < ActionController::TestCase
  ### Helper functions ###

  setup :initialize_record

  def teardown
  	@record = nil
  end

  ### Function Tests ###

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:records)
  end

  test "should show record" do
  	get :show, id: @record.id
  	assert_response :success
  end

  test "should successfully create" do
  	assert_difference('Record.count') do
      post :create, record: {id: 20, date: "2015-01-04", account_id: 0, ticket_id: 0, income: 10.00, expense: 0.00, total: 10.00, settled: true}
  	end
 
  	assert_redirected_to record_path(assigns(:record))
  end

  test "should successfully update" do
  	notes = "Test notes here."
  	patch :update, id: @record.id, record: { notes: notes }
  	assert_redirected_to record_path(assigns(:record))
  	@record.reload
  	assert_equal @record.notes, notes
  end

  test "unsuccessful edit" do
  	get :edit, id: @record.id
  	assert_template 'records/edit', locals: { id: @record.id }
  	assert_raises(ActiveRecord::RecordInvalid) { patch :update, id: @record.id, record: { income: "bad" } }
  	assert_template
  end

  test "should destroy record" do
  	assert_difference('Record.count', -1) do
      delete :destroy, id: @record.id
  	end
 
  	assert_redirected_to records_path
  end

  ### Routing tests ###

  test "should route to record" do
    assert_routing '/records/0', { controller: "records", action: "show", id: "0" }
  end

  test "should route to create record" do
  	assert_routing({ method: 'post', path: '/records' }, { controller: "records", action: "create" })
  end

  ### Layout tests ###

  test "index should render correct layout" do
  	get :index
  	assert_template :index
  	assert_template layout: "layouts/application"
  end

  test "show should render correct layout" do
  	get :show, id: @record.id
  	assert_template :show, locals: { id: @record.id }
  	assert_template layout: "layouts/application"
  end

  test "new should render correct layout" do
  	get :new
  	assert_template :new
  	assert_template layout: "layouts/application", partial: "_form"
  end

  test "edit should render correct layout" do
  	get :edit, id: @record.id
  	assert_template :edit, locals: { id: @record.id }
  	assert_template layout: "layouts/application", partial: "_form"
  end

  ### Exception Tests ###

  test "show should reroute to record not found" do
    assert_raises(RuntimeError) { get :show, id: 999 }
  end

  test "edit should throw not found exception" do
    assert_raises(RuntimeError) { get :edit, id: 999 }
  end

  test "destroy should throw not found exception" do
    assert_raises(RuntimeError) { delete :destroy, id: 999 }
  end

  private

  	def initialize_record
  	  @record = records(:one)
  	end
end