require 'test_helper'

class ServiceTest < ActiveSupport::TestCase
  ### Create Testing ###

  test "new empty" do
  	service = Service.new
  	assert_raises(ActiveRecord::RecordInvalid) { service.save! } # "Created a new service without any values"
  end

  test "new missing id" do
  	service = Service.new(:category => "Test service", :price => 0.00, :rate => "Flat")
  	assert_raises(ActiveRecord::RecordInvalid) { service.save! } # "Created a new service without an id"
  end

  test "new missing category" do
  	service = Service.new(:id => 2, :price => 0.00, :rate => "Flat")
  	assert_raises(ActiveRecord::RecordInvalid) { service.save! } # "Created a new service without a category"
  end

  test "new missing price" do
  	service = Service.new(:id => 2, :category => "Test service", :rate => "Flat")
  	assert_raises(ActiveRecord::RecordInvalid) { service.save! } # "Created a new service without a price"
  end

  test "new missing rate" do
  	service = Service.new(:id => 2, :category => "Test service", :price => 0.00)
  	assert_raises(ActiveRecord::RecordInvalid) { service.save! } # "Created a new service without a rate"
  end

  test "new bad price" do
  	service = Service.new(:id => 2, :category => "Test service", :price => "string60.00", :rate => "Flat")
  	assert_raises(ActiveRecord::RecordInvalid) { service.save! } # "Created a new service with a non-numeric price"
  end

  test "new dup id" do
  	service = Service.new(:id => 0, :category => "Test service", :price => 0.00, :rate => "Flat")
  	assert_raises(ActiveRecord::RecordInvalid) { service.save! } # "Created a new service with a duplicate ID"
  end

  test "new valid" do
  	service = Service.new(:id => 2, :category => "Test service", :price => 60.00, :rate => "Flat")
  	assert_nothing_raised(ActiveRecord::RecordInvalid) { service.save! } # "Did not create new service with all necessary values"

    assert_equal 2, service.id, "Did not recieve expected id from service after successful creation"
    assert_equal "Test service", service.category, "Did not recieve expected category from service after successful creation"
    assert_in_delta 60.00, service.price, 0.0001, "Did not recieve expected price from service after successful creation"
    assert_equal "Flat", service.rate, "Did not recieve expected rate from service after successful creation"
  end

  ### Update testing ###

  def setup
    unless @service.nil?
      @service.destroy!
    end
  	@service = Service.new(:id => 21, :category => "Test service", :price => 60.00, :rate => "Flat")
  	@service.save!
  	verify("before")
  end

  def verify(status)
  	@service.reload
  	assert_equal 21, @service.id, "Did not recieve expected id from service #{status} update"
  	assert_equal "Test service", @service.category, "Did not recieve expected category from service #{status} update"
  	assert_in_delta 60.00, @service.price, 0.0001, "Did not recieve expected price from service #{status} update"
  	assert_equal "Flat", @service.rate, "Did not recieve expected rate from service #{status} update"
  end

  test "update valid" do
  	setup

  	assert_nothing_raised(ActiveRecord::RecordInvalid) { @service.update!(:category => "Updated Test service", :price => 70.00, :rate => "Hourly") } # "Unsuccess update of service with valid values"

	  assert_equal "Updated Test service", @service.category, "Did not recieve expected category from service after update"
  	assert_in_delta 70.00, @service.price, 0.0001, "Did not recieve expected price from service after update"
  	assert_equal "Hourly", @service.rate, "Did not recieve expected rate from service after update"
  end

  test "update bad price" do
  	setup
  	assert_raises(ActiveRecord::RecordInvalid) { @service.update!(:price => "bad") }
  	verify("after")
  end

  ### Read testing ###

  test "read service1" do
  	service1 = services(:service1)
  	assert_equal 0, service1.id, "Did not recieve expected id from service1"
  	assert_equal "Test Service 1", service1.category, "Did not recieve expected category from service1"
  	assert_in_delta 50.00, service1.price, 0.0001, "Did not recieve expected price from service1"
  	assert_equal "Hourly", service1.rate, "Did not recieve expected rate from service1"
  end

  test "read service2" do
  	service2 = services(:service2)
  	assert_equal 1, service2.id, "Did not recieve expected id from service2"
  	assert_equal "Test Service 2", service2.category, "Did not recieve expected category from service2"
  	assert_in_delta 60.00, service2.price, 0.0001, "Did not recieve expected price from service2"
  	assert_equal "Flat", service2.rate, "Did not recieve expected rate from service2"
  end

end
