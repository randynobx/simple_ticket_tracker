require 'test_helper'

class RecordTest < ActiveSupport::TestCase
  ### Create testing ###

  test "new empty" do
  	record = Record.new
  	assert_raises(ActiveRecord::RecordInvalid) { record.save! } # "Created empty record"
  end

  test "new duplicate id" do
  	record = Record.new(:id => 0, :date => "2015-01-01", :account_id => 0, :ticket_id => 0, :income => 0.00, :expense => 0.00, :total => 0.00, :settled => false)
  	assert_raises(ActiveRecord::RecordInvalid) { record.save! } # "Created record with duplicate id"
  end

  test "new missing id" do
  	record = Record.new(:date => "2015-01-01", :account_id => 0, :ticket_id => 0, :income => 0.00, :expense => 0.00, :total => 0.00, :settled => true)
  	assert_raises(ActiveRecord::RecordInvalid) { record.save! } # "Created record without id"
  end
  
  test "new missing date" do
  	record = Record.new(:id => 20, :account_id => 0, :ticket_id => 0, :income => 0.00, :expense => 0.00, :total => 0.00, :settled => true)
  	assert_raises(ActiveRecord::RecordInvalid) { record.save! } # "Created record without a date"
  end
  
  test "new missing account_id" do
  	record = Record.new(:id => 20, :date => "2015-01-01", :ticket_id => 0, :income => 0.00, :expense => 0.00, :total => 0.00, :settled => true)
  	assert_raises(ActiveRecord::RecordInvalid) { record.save! } # "Created record without an account_id"
  end

  test "new missing ticket_id" do
  	record = Record.new(:id => 20, :date => "2015-01-01", :account_id => 0, :income => 0.00, :expense => 0.00, :total => 0.00, :settled => true)
  	assert_raises(ActiveRecord::RecordInvalid) { record.save! } # "Created record without a ticket_id"
  end

  test "new missing income" do
  	record = Record.new(:id => 20, :date => "2015-01-01", :account_id => 0, :ticket_id => 0, :expense => 0.00, :total => 0.00, :settled => true)
  	assert_raises(ActiveRecord::RecordInvalid) { record.save! } # "Created record without an income value"
  end

  test "new missing expense" do
  	record = Record.new(:id => 20, :date => "2015-01-01", :account_id => 0, :ticket_id => 0, :income => 0.00, :total => 0.00, :settled => true)
  	assert_raises(ActiveRecord::RecordInvalid) { record.save! } # "Created record without an expense value"
  end

  test "new missing total" do
  	record = Record.new(:id => 20, :date => "2015-01-01", :account_id => 0, :ticket_id => 0, :income => 0.00, :expense => 0.00, :settled => true)
  	assert_raises(ActiveRecord::RecordInvalid) { record.save! } # "Created record without a total value"
  end
  
  test "new minimal" do
  	record = Record.new(:id => 21, :date => "2015-01-01", :account_id => 0, :ticket_id => 0, :income => 0.00, :expense => 0.00, :total => 0.00, :settled => true)
  	assert_nothing_raised(ActiveRecord::RecordInvalid) { record.save! } # "Unsuccessful creation of record with mimimum sufficient information"

  	record.reload
  	assert_equal 21, record.id, "Did not recieve expected id from service after successful creation"
  	assert_equal "2015-01-01", record.date.to_s, "Did not recieve expected date from service after successful creation"
  	assert_equal 0, record.account_id, "Did not recieve expected account_id from service after successful creation"
  	assert_equal 0, record.ticket_id, "Did not recieve expected ticket_id from service after successful creation"
  	assert_in_delta 0.00, record.income, 0.0001, "Did not recieve expected income from service after successful creation"
  	assert_in_delta 0.00, record.expense, 0.0001, "Did not recieve expected expense from service after successful creation"
  	assert_in_delta 0.00, record.total, 0.0001, "Did not recieve expected total from service after successful creation"
  	assert record.settled, "Did not recieve expected settled from service after successful creation"
  	assert_nil record.notes, "Did not recieve expected notes from service after successful creation"
  end
  
  test "new full" do
  	record = Record.new(:id => 21, :date => "2015-01-01", :account_id => 0, :ticket_id => 0, :income => 0.00, :expense => 0.00, :total => 0.00, :notes => "Notes go here", :settled => true)
  	assert_nothing_raised(ActiveRecord::RecordInvalid) { record.save! } # "Unsuccessful creation of record with maximum information"

  	record.reload
  	assert_equal 21, record.id, "Did not recieve expected id from service after successful creation"
  	assert_equal "2015-01-01", record.date.to_s, "Did not recieve expected date from service after successful creation"
  	assert_equal 0, record.account_id, "Did not recieve expected account_id from service after successful creation"
  	assert_equal 0, record.ticket_id, "Did not recieve expected ticket_id from service after successful creation"
  	assert_in_delta 0.00, record.income, 0.0001, "Did not recieve expected income from service after successful creation"
  	assert_in_delta 0.00, record.expense, 0.0001, "Did not recieve expected expense from service after successful creation"
  	assert_in_delta 0.00, record.total, 0.0001, "Did not recieve expected total from service after successful creation"
  	assert record.settled, "Did not recieve expected settled from service after successful creation"
  	assert_equal "Notes go here", record.notes, "Did not recieve expected notes from service after successful creation"
  end

  test "new non-numeric account_id" do
  	record = Record.new(:id => 20, :date => "2015-01-01", :account_id => "bad", :ticket_id => 0, :income => 0.00, :expense => 0.00, :total => 0.00, :settled => true)
  	assert_raises(ActiveRecord::RecordInvalid) { record.save! } # "Created record without an account_id"
  end

  test "new non-numeric ticket_id" do
  	record = Record.new(:id => 20, :date => "2015-01-01", :account_id => 0, :ticket_id => "bad", :income => 0.00, :expense => 0.00, :total => 0.00, :settled => true)
  	assert_raises(ActiveRecord::RecordInvalid) { record.save! } # "Created record without a ticket_id"
  end

  test "new non-existant account_id" do
  	record = Record.new(:id => 20, :date => "2015-01-01", :account_id => 999, :ticket_id => 0, :income => 0.00, :expense => 0.00, :total => 0.00, :settled => true)
  	assert_raises(ActiveRecord::RecordInvalid) { record.save! } # "Created record without an account_id"
  end

  test "new non-existant ticket_id" do
  	record = Record.new(:id => 20, :date => "2015-01-01", :account_id => 0, :ticket_id => 999, :income => 0.00, :expense => 0.00, :total => 0.00, :settled => true)
  	assert_raises(ActiveRecord::RecordInvalid) { record.save! } # "Created record without a ticket_id"
  end
  
  test "new bad income" do
  	record = Record.new(:id => 20, :date => "2015-01-01", :account_id => 0, :ticket_id => 0, :income => "bad", :expense => 0.00, :total => 0.00, :settled => true)
  	assert_raises(ActiveRecord::RecordInvalid) { record.save! } # "Created record with non-numeric income"
  end
  
  test "new bad expense" do
  	record = Record.new(:id => 20, :date => "2015-01-01", :account_id => 0, :ticket_id => 0, :income => 0.00, :expense => "bad", :total => 0.00, :settled => true)
  	assert_raises(ActiveRecord::RecordInvalid) { record.save! } # "Created record with non-numeric expense"
  end
  
  test "new bad total" do
  	record = Record.new(:id => 20, :date => "2015-01-01", :account_id => 0, :ticket_id => 0, :income => 0.00, :expense => 0.00, :total => "bad", :settled => true)
  	assert_raises(ActiveRecord::RecordInvalid) { record.save! } # "Created record with non-numeric total"
  end
  
  test "new long notes" do
  	record = Record.new(:id => 20, :date => "2015-01-01", :account_id => 0, :ticket_id => 0, :income => 0.00, :expense => 0.00, :total => 0.00, :settled => true, :notes => "abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890")
  	assert_raises(ActiveRecord::RecordInvalid) { record.save! } # "Created record with notes field of >1000 chars"
  end

  ### Update testing ###

  def setup
    unless @record.nil?
      @record.destroy!
    end
    @record = Record.new(:id => 20, :date => "2015-01-01", :account_id => 0, :ticket_id => 0, :income => 50.00, :expense => 0.00, :total => 50.00, :settled => true, :notes => "some notes.")
    @record.save!
  	verify("before")
  end

  def verify(status)
    @record.reload
  	assert_equal 20, @record.id, "Did not recieve expected id from service #{status} update"
  	assert_equal "2015-01-01", @record.date.to_s, "Did not recieve expected date from service #{status} update"
  	assert_equal 0, @record.account_id, "Did not recieve expected account_id from service #{status} update"
  	assert_equal 0, @record.ticket_id, "Did not recieve expected ticket_id from service #{status} update"
  	assert_in_delta 50.00, @record.income, 0.0001, "Did not recieve expected income from service #{status} update"
  	assert_in_delta 0.00, @record.expense, 0.0001, "Did not recieve expected expense from service #{status} update"
  	assert_in_delta 50.00, @record.total, 0.0001, "Did not recieve expected total from service #{status} update"
  	assert @record.settled, "Did not recieve expected settled from service #{status} update"
  	assert_equal "some notes.", @record.notes, "Did not recieve expected notes from service #{status} update"
  end

  test "update valid minimal" do
  	setup
  	assert_nothing_raised(ActiveRecord::RecordInvalid) { @record.update!(:id => 20, :date => "2015-01-02", :account_id => 0, :ticket_id => 0, :income => 100.00, :expense => 25.00, :total => 75.00) } # "Unsuccessful update of record with mimimum information"

  	assert_equal 20, @record.id, "Did not recieve expected id from record after update"
  	assert_equal "2015-01-02", @record.date.to_s, "Did not recieve expected date from record after update" "date"
  	assert_equal 0, @record.account_id, "Did not recieve expected account_id from record after update"
  	assert_equal 0, @record.ticket_id, "Did not recieve expected account_id from record after update"
  	assert_in_delta 100.00, @record.income, 0.0001, "Did not recieve expected account_id from record after update"
  	assert_in_delta 25.00, @record.expense, 0.0001, "Did not recieve expected account_id from record after update"
  	assert_in_delta 75.00, @record.total, 0.0001, "Did not recieve expected account_id from record after update"
  	assert @record.settled, "Did not recieve expected account_id from record after update"
  	assert_equal "some notes.", @record.notes, "Did not recieve expected account_id from record after update"
  	
  end
  
  test "update valid full" do
  	setup
  	assert_nothing_raised(ActiveRecord::RecordInvalid) { @record.update!(:id => 20, :date => "2015-02-01", :account_id => 0, :ticket_id => 0, :income => 70.00, :expense => 10.00, :total => 60.00, :notes => "Notes go here", :settled => false) } # "Unsuccessful update of record with maximum information"
  	
  	assert_equal 20, @record.id, "Did not recieve expected id from record after update"
  	assert_equal "2015-02-01", @record.date.to_s, "Did not recieve expected date from record after update" "date"
  	assert_equal 0, @record.account_id, "Did not recieve expected account_id from record after update"
  	assert_equal 0, @record.ticket_id, "Did not recieve expected account_id from record after update"
  	assert_in_delta 70.00, @record.income, 0.0001, "Did not recieve expected account_id from record after update"
  	assert_in_delta 10.00, @record.expense, 0.0001, "Did not recieve expected account_id from record after update"
  	assert_in_delta 60.00, @record.total, 0.0001, "Did not recieve expected account_id from record after update"
  	assert_not @record.settled, "Did not recieve expected account_id from record after update"
  	assert_equal "Notes go here", @record.notes, "Did not recieve expected account_id from record after update"
  end
  
  test "update bad income" do
  	setup
  	assert_raises(ActiveRecord::RecordInvalid) { @record.update!(:income => "bad") }# "Created record with non-numeric income"
  	verify("after")
  end
  
  test "update bad expense" do
  	setup
  	assert_raises(ActiveRecord::RecordInvalid) { @record.update!(:expense => "bad") } # "Created record with non-numeric expense"
  	verify("after")
  end
  
  test "update bad total" do
  	setup
  	assert_raises(ActiveRecord::RecordInvalid) { @record.update!(:total => "bad") } # "Created record with non-numeric total"
  	verify("after")
  end
  
  test "update long notes" do
  	setup
  	assert_raises(ActiveRecord::RecordInvalid) { @record.update!(:notes => "abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890") } # "Created record with notes field of >1000 chars"
  end

  ### Test read ###

  test "read record1" do
  	record1 = records(:one)
  	assert_equal 0, record1.id, "Did not recieve expected id from record1"
  	assert_equal "2015-01-27", record1.date.to_s, "Did not recieve expected date from record1"
  	assert_equal 0, record1.account_id, "Did not recieve expected account_id from record1"
  	assert_equal 0, record1.ticket_id, "Did not recieve expected ticket_id from record1"
  	assert_nil record1.notes, "Did not recieve expected notes from record1"
  	assert_equal true, record1.settled, "Did not recieve expected settled value from record1"
  	assert_in_delta 60.00, record1.income, 0.0001, "Did not recieve expected income from record1"
  	assert_in_delta 0.00, record1.expense, 0.0001, "Did not recieve expected expense from record1"
  	assert_in_delta 60.00, record1.total, 0.0001, "Did not recieve expected total from record1"
  end

  test "read record2" do
	record2 = records(:two)
  	assert_equal 1, record2.id, "Did not recieve expected id from record2"
  	assert_equal "2015-02-02", record2.date.to_s, "Did not recieve expected date from record2"
  	assert_equal 2, record2.account_id, "Did not recieve expected account_id from record2"
  	assert_equal 1, record2.ticket_id, "Did not recieve expected ticket_id from record2"
  	assert_equal "parts", record2.notes, "Did not recieve expected notes from record2"
  	assert_equal false, record2.settled, "Did not recieve expected settled value from record2"
  	assert_in_delta 0.00, record2.income, 0.0001, "Did not recieve expected income from record2"
  	assert_in_delta 140.49, record2.expense, 0.0001, "Did not recieve expected expense from record2"
  	assert_in_delta -140.49, record2.total, 0.0001, "Did not recieve expected total from record2"
  end
end
