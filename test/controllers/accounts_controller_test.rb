require 'test_helper'

class AccountsControllerTest < ActionController::TestCase
  ### Helper functions ###

  setup :initialize_account
  
  def teardown
  	@account = nil
  end

  ### Function Tests ###

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:accounts)
  end

  test "should show account" do
  	get :show, id: @account.id
  	assert_response :success
  end

  test "should successfully create" do
  	assert_difference('Account.count') do
      post :create, account: { id: 20, category: "Client", name: "Joe" }
  	end
 
  	assert_redirected_to account_path(assigns(:account))
  end

  test "should successfully update" do
  	notes = "Test notes here."
  	patch :update, id: @account.id, account: { notes: notes }
  	assert_redirected_to account_path(assigns(:account))
  	@account.reload
  	assert_equal @account.notes, notes
  end

  test "unsuccessful edit" do
  	get :edit, id: @account.id
  	assert_template 'accounts/edit', locals: { id: @account.id}
  	assert_raises(ActiveRecord::RecordInvalid) { patch :update, id: @account.id, account: { email: "admin@invalid" } }
  	assert_template
  end

  test "should destroy account" do
  	assert_difference('Account.count', -1) do
      delete :destroy, id: @account.id
  	end
 
  	assert_redirected_to accounts_path
  end

  ### Routing tests ###

  test "should route to account" do
    assert_routing '/accounts/0', { controller: "accounts", action: "show", id: "0" }
  end

  test "should route to create account" do
    assert_routing({ method: 'post', path: '/accounts' }, { controller: "accounts", action: "create" })
  end

  test "should route to edit account" do
    assert_routing({ method: 'patch', path: '/accounts/0' }, { controller: "accounts", action: "update", id: "0" })
  end

  test "should route to destroy account" do
    assert_routing({ method: 'delete', path: '/accounts/0' }, { controller: "accounts", action: "destroy", id: "0" })
  end

  ### Layout tests ###

  test "index should render correct layout" do
  	get :index
  	assert_template :index
  	assert_template layout: "layouts/application"
  end

  test "show should render correct layout" do
  	get :show, id: @account.id
  	assert_template :show, locals: { id: 999 }
  	assert_template layout: "layouts/application"
  end

  test "new should render correct layout" do
  	get :new
  	assert_template :new
  	assert_template layout: "layouts/application", partial: "_form"
  end

  test "edit should render correct layout" do
  	get :edit, id: @account.id
  	assert_template :edit, locals: { id: @account.id }
  	assert_template layout: "layouts/application", partial: "_form"
  end

  ### Exception tests ###

  test "show should throw not found exception" do
    assert_raises(RuntimeError) { get :show, id: 999 }
  end

  test "edit should throw not found exception" do
    assert_raises(RuntimeError) { get :edit, id: 999 }
  end

  test "destroy should throw not found exception" do
    assert_raises(RuntimeError) { delete :destroy, id: 999 }
  end

  private
  	def initialize_account
  	  @account = accounts(:Client1)
  	end
end
