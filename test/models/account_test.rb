require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  ### Create testing ###

  test "new empty" do
  	account = Account.new
  	assert_raises(ActiveRecord::RecordInvalid) { account.save! } # "Created empty account"
  end

  test "new missing id" do
  	account = Account.new(:category => "Client", :name => "Joe Schmoe")
  	assert_raises(ActiveRecord::RecordInvalid) { account.save! } # "Created account with only id"
  end

  test "new duplicate id" do
  	account = Account.new(:id => 0, :category => "Client", :name => "Duplicate ID Guy")
  	assert_raises(ActiveRecord::RecordInvalid) { account.save! } # "Created account with duplicate id"
  end

  test "new missing category" do
  	account = Account.new(:id => 90, :name => "Joe Schmoe")
  	assert_raises(ActiveRecord::RecordInvalid) { account.save! } # "Created account with only a category"
  end
  
  test "new missing name" do
  	account = Account.new(:id => 90, :category => "Client")
  	assert_raises(ActiveRecord::RecordInvalid) { account.save! } # "Created account with only a name"
  end
  
  test "new valid minimal" do
  	account = Account.new(:id => 90, :category => "Client", :name => "Joe Schmoe")
  	assert_nothing_raised(ActiveRecord::RecordInvalid) { account.save! } # "Unsuccessful creation of account with mimimum information"

  	account = Account.find(90)
  	assert_equal 90, account.id, "Did not recieve expected id from account after creation"
  	assert_equal "Client", account.category, "Did not recieve expected category from account after creation"
  	assert_equal "Joe Schmoe", account.name, "Did not recieve expected name from account after creation"
  	assert_nil account.business, "Did not recieve expected business from account after creation"
  	assert_nil account.phone, "Did not recieve expected phone from account after creation"
  	assert_nil account.email, "Did not recieve expected email from account after creation"
  	assert_nil account.address, "Did not recieve expected address from account after creation"
  	assert_nil account.city, "Did not recieve expected city from account after creation"
  	assert_nil account.state, "Did not recieve expected state from account after creation"
  	assert_nil account.zip, "Did not recieve expected zip from account after creation"
  	assert_nil account.notes, "Did not recieve expected notes from account after creation"
  end
  
  test "new valid full" do
  	account = Account.new(:id => 4, :category => "Client", :name => "Jon Doe", :business => "Business", :phone => "(555) 555-5555", :email => "jon@domain.com", :address => "123 Some Street", :city => "Anytown", :state => "US", :zip => "55555", :notes => "Some notes go here")
  	assert_nothing_raised(ActiveRecord::RecordInvalid) { account.save! } # "Unsuccessful creation of account with maximum information"

  	account = Account.find(4)
	assert_equal 4, account.id, "Did not recieve expected id from account after creation"
  	assert_equal "Client", account.category, "Did not recieve expected category from account after creation"
  	assert_equal "Jon Doe", account.name, "Did not recieve expected name from account after creation"
  	assert_equal "Business", account.business, "Did not recieve expected business from account after creation"
  	assert_equal "(555) 555-5555", account.phone, "Did not recieve expected phone from account after creation"
  	assert_equal "jon@domain.com", account.email, "Did not recieve expected email from account after creation"
  	assert_equal "123 Some Street", account.address, "Did not recieve expected address from account after creation"
  	assert_equal "Anytown", account.city, "Did not recieve expected city from account after creation"
  	assert_equal "US", account.state, "Did not recieve expected state from account after creation"
  	assert_equal "55555", account.zip, "Did not recieve expected zip from account after creation"
  	assert_equal "Some notes go here", account.notes, "Did not recieve expected notes from account after creation"
  end
  
  test "new bad email 1" do
  	account = Account.new(:id => 5, :category => "Client", :name => "Joe Schmoe", :email => "uuser.com")
  	assert_raises(ActiveRecord::RecordInvalid) { account.save! } # "Created account with bad email. No user or @"
  end
  
  test "new bad email 2" do
  	account = Account.new(:id => 6, :category => "Client", :name => "Joe Schmoe", :email => "uuser@.com")
  	assert_raises(ActiveRecord::RecordInvalid) { account.save! } # "Created account with bad email. No domain"
  end
  
  test "new bad email 3" do
  	account = Account.new(:id => 7, :category => "Client", :name => "Joe Schmoe", :email => "uuser@do")
  	assert_raises(ActiveRecord::RecordInvalid) { account.save! } # "Created account with bad email. No TLD"
  end
  
  test "new long notes" do
  	account = Account.new(:id => 8, :category => "Client", :name => "Joe Schmoe", :notes => "abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890")
  	assert_raises(ActiveRecord::RecordInvalid) { account.save! } # "Created account with notes field of >144 chars"
  end

  test "new long addr" do
  	account = Account.new(:id => 9, :category => "Client", :name => "Joe Schmoe", :address => "abcdefghijklmnopqrstuvwxyz1234567890")
  	assert_raises(ActiveRecord::RecordInvalid) { account.save! } # "Created account with address field of >30 chars"
  end

  test "new long city" do
  	account = Account.new(:id => 10, :category => "Client", :name => "Joe Schmoe", :city => "abcdefghijklmnopqrstuvwxyz")
  	assert_raises(ActiveRecord::RecordInvalid) { account.save! } # "Created account with city field of >20 chars"
  end

  test "new long state" do
  	account = Account.new(:id => 5, :category => "Client", :name => "Joe Schmoe", :state => "ABC")
  	assert_raises(ActiveRecord::RecordInvalid) { account.save! } # "Created account with state field of >2 chars"
  end

  test "new long zip" do
  	account = Account.new(:id => 5, :category => "Client", :name => "Joe Schmoe", :zip => 1234567)
  	assert_raises(ActiveRecord::RecordInvalid) { account.save! } # "Created account with zip field of >5 chars"
  end

  ### Update testing ###

  def setup
  	unless @account.nil?
      @account.destroy!
    end
    @account = Account.new(:id => 5, :category => "Client", :name => "Joe Schmoe", :business => "Business", :phone => "(555) 555-5555", :email => "joe@domain.com", :address => "123 Some Street", :city => "Anytown", :state => "US", :zip => "55555", :notes => "Some notes go here")
  	@account.save!
  	verify("before")
  end

  def verify(status)
  	@account.reload
  	assert_equal 5, @account.id, "Did not recieve expected id from account #{status} update"
  	assert_equal "Client", @account.category, "Did not recieve expected category from account #{status} update"
  	assert_equal "Joe Schmoe", @account.name, "Did not recieve expected name from account #{status} update"
  	assert_equal "Business", @account.business, "Did not recieve expected business from account #{status} update"
  	assert_equal "(555) 555-5555", @account.phone, "Did not recieve expected phone from account #{status} update"
  	assert_equal "joe@domain.com", @account.email, "Did not recieve expected email from account #{status} update"
  	assert_equal "123 Some Street", @account.address, "Did not recieve expected address from account #{status} update"
  	assert_equal "Anytown", @account.city, "Did not recieve expected city from account #{status} update"
  	assert_equal "US", @account.state, "Did not recieve expected state from account #{status} update"
  	assert_equal "55555", @account.zip, "Did not recieve expected zip from account #{status} update"
  	assert_equal "Some notes go here", @account.notes, "Did not recieve expected notes from account #{status} update"
  end

  test "update minimal" do
  	setup

  	assert_nothing_raised(ActiveRecord::RecordInvalid) { @account.update!(:category => "Vendor", :name => "John Schmoe") } # "Unsuccessful update of account with mimimum information"
  
  	assert_equal 5, @account.id, "Did not recieve expected id from account after update"
  	assert_equal "Vendor", @account.category, "Did not recieve expected category from account after update"
  	assert_equal "John Schmoe", @account.name, "Did not recieve expected name from account after update"
  	assert_equal "Business", @account.business, "Did not recieve expected business from account after update"
  	assert_equal "(555) 555-5555", @account.phone, "Did not recieve expected phone from account after update"
  	assert_equal "joe@domain.com", @account.email, "Did not recieve expected email from account after update"
  	assert_equal "123 Some Street", @account.address, "Did not recieve expected address from account after update"
  	assert_equal "Anytown", @account.city, "Did not recieve expected city from account after update"
  	assert_equal "US", @account.state, "Did not recieve expected state from account after update"
  	assert_equal "55555", @account.zip, "Did not recieve expected zip from account after update"
  	assert_equal "Some notes go here", @account.notes, "Did not recieve expected notes from account after update"
  end
  
  test "update full" do
  	setup

  	assert_nothing_raised(ActiveRecord::RecordInvalid) { @account.update!(:category => "Vendor", :name => "Jon Doe", :business => "Biz", :phone => "(555) 666-7777", :email => "jon@domain.com", :address => "124 Some Street", :city => "AnyCity", :state => "EU", :zip => "11111", :notes => "More notes") } # "Unsuccessful update of account with maximum information"

  	assert_equal 5, @account.id, "Did not recieve expected id from account after update"
  	assert_equal "Vendor", @account.category, "Did not recieve expected category from account after update"
  	assert_equal "Jon Doe", @account.name, "Did not recieve expected name from account after update"
  	assert_equal "Biz", @account.business, "Did not recieve expected business from account after update"
  	assert_equal "(555) 666-7777", @account.phone, "Did not recieve expected phone from account after update"
  	assert_equal "jon@domain.com", @account.email, "Did not recieve expected email from account after update"
  	assert_equal "124 Some Street", @account.address, "Did not recieve expected address from account after update"
  	assert_equal "AnyCity", @account.city, "Did not recieve expected city from account after update"
  	assert_equal "EU", @account.state, "Did not recieve expected state from account after update"
  	assert_equal "11111", @account.zip, "Did not recieve expected zip from account after update"
  	assert_equal "More notes", @account.notes, "Did not recieve expected notes from account after update"
  end
  
  test "update bad email 1" do
  	setup
  	assert_raises(ActiveRecord::RecordInvalid) { @account.update!(:id => 5, :category => "Client", :name => "Joe Schmoe", :email => "uuser.com") } # "Updated account with bad email. No user or @"
  	verify("after")
  end
  
  test "update bad email 2" do
  	setup
  	assert_raises(ActiveRecord::RecordInvalid) { @account.update!(:id => 5, :category => "Client", :name => "Joe Schmoe", :email => "uuser@.com") } # "Updated account with bad email. No domain"
  	verify("after")
  end
  
  test "update bad email 3" do
  	setup
  	assert_raises(ActiveRecord::RecordInvalid) { @account.update!(:id => 5, :category => "Client", :name => "Joe Schmoe", :email => "uuser@do") } # "Updated account with bad email. No TLD"
  	verify("after")
  end
  
  test "update long notes" do
  	setup
  	assert_raises(ActiveRecord::RecordInvalid) { @account.update!(:id => 5, :category => "Client", :name => "Joe Schmoe", :notes => "abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklm,fghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890") } # "Updated account with notes field of >144 chars"
  	verify("after")
  end

  test "update long addr" do
  	setup
  	assert_raises(ActiveRecord::RecordInvalid) { @account.update!(:id => 5, :category => "Client", :name => "Joe Schmoe", :address => "abcdefghijklmnopqrstuvwxyz1234567890") } # "Updated account with address field of >30 chars"
  	verify("after")
  end

  test "update long city" do
  	setup
  	assert_raises(ActiveRecord::RecordInvalid) { @account.update!(:id => 5, :category => "Client", :name => "Joe Schmoe", :city => "abcdefghijklmnopqrstuvwxyz") } # "Updated account with city field of >20 chars"
  	verify("after")
  end

  test "update long state" do
  	setup
  	assert_raises(ActiveRecord::RecordInvalid) { @account.update!(:id => 5, :category => "Client", :name => "Joe Schmoe", :state => "ABC") } # "Updated account with state field of >2 chars"
  	verify("after")
  end

  test "update long zip" do
  	setup
  	assert_raises(ActiveRecord::RecordInvalid) { @account.update!(:id => 5, :category => "Client", :name => "Joe Schmoe", :zip => 1234567) } # "Updated account with zip field of >5 chars"
  	verify("after")
  end

  ### Test read ###

  test "read client1" do
  	client1 = accounts(:Client1)
  	assert_equal 0, client1.id, "Did not recieve expected id from client1"
  	assert_equal "Client", client1.category, "Did not recieve expected category from client1"
  	assert_equal "John Doe", client1.name, "Did not recieve expected name from client1"
  	assert_equal "Retail Inc.", client1.business, "Did not recieve expected business from client1"
  	assert_equal "(555) 555-5555", client1.phone, "Did not recieve expected phone from client1"
  	assert_equal "john@retailinc.com", client1.email, "Did not recieve expected email address from client1"
  	assert_equal "123 Basic Street", client1.address, "Did not recieve expected address from client1"
  	assert_equal "Anytown", client1.city, "Did not recieve expected city from client1"
  	assert_equal "ST", client1.state, "Did not recieve expected state from client1"
  	assert_equal "55555", client1.zip, "Did not recieve expected zip from client1"
  	assert_equal "My first customer.", client1.notes, "Did not recieve expected notes from client1"
  end

  test "read vendor1" do
  	vendor1 = accounts(:Vendor1)
  	assert_equal 2, vendor1.id, "Did not recieve expected id from vendor1"
  	assert_equal "Vendor", vendor1.category, "Did not recieve expected category from vendor1"
  	assert_equal "Parts Supplier Inc", vendor1.name, "Did not recieve expected name from vendor1"
  	assert_nil vendor1.business, "Did not recieve expected business from vendor1"
  	assert_nil vendor1.phone, "Did not recieve expected phone from vendor1"
  	assert_nil vendor1.email, "Did not recieve expected email address from vendor1"
  	assert_nil vendor1.address, "Did not recieve expected address from vendor1"
  	assert_nil vendor1.city, "Did not recieve expected city from vendor1"
  	assert_nil vendor1.state, "Did not recieve expected state from vendor1"
  	assert_nil vendor1.zip, "Did not recieve expected zip from vendor1"
  	assert_nil vendor1.notes, "Did not recieve expected notes from vendor1"
  end
end
