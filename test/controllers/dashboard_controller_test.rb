require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_template layout: 'layouts/application', partial: "_listing", count: 2
  end

end
