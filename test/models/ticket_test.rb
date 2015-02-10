require 'test_helper'

class TicketTest < ActiveSupport::TestCase
  ### Create Testing ###
  test "new empty" do
  	ticket = Ticket.new
  	assert_raises(ActiveRecord::RecordInvalid) { ticket.save! }
  end

  test "new missing id" do
  	ticket = Ticket.new(:date => "2015-02-01", :account_id => 0, :service_id => 0, :materialscost => 0.00, :labor => 50.00, :total => 50.00, :closed => true)
  	assert_raises(ActiveRecord::RecordInvalid) { ticket.save! }
  end

  test "new missing date" do
  	ticket = Ticket.new(:id => 20, :account_id => 0, :service_id => 0, :materialscost => 0.00, :labor => 50.00, :total => 50.00, :closed => true)
  	assert_raises(ActiveRecord::RecordInvalid) { ticket.save! }
  end

  test "new missing account_id" do
  	ticket = Ticket.new(:id => 20, :date => "2015-02-01", :service_id => 0, :materialscost => 0.00, :labor => 50.00, :total => 50.00, :closed => true)
  	assert_raises(ActiveRecord::RecordInvalid) { ticket.save! }
  end

  test "new missing service_id" do
  	ticket = Ticket.new(:id => 20, :date => "2015-02-01", :account_id => 0, :materialscost => 0.00, :labor => 50.00, :total => 50.00, :closed => true)
  	assert_raises(ActiveRecord::RecordInvalid) { ticket.save! }
  end

  test "new missing materialscost" do
  	ticket = Ticket.new(:id => 20, :date => "2015-02-01", :account_id => 0, :service_id => 0, :labor => 50.00, :total => 50.00, :closed => true)
  	assert_raises(ActiveRecord::RecordInvalid) { ticket.save! }
  end

  test "new missing labor" do
  	ticket = Ticket.new(:id => 20, :date => "2015-02-01", :account_id => 0, :service_id => 0, :materialscost => 0.00, :total => 50.00, :closed => true)
  	assert_raises(ActiveRecord::RecordInvalid) { ticket.save! }
  end

  test "new missing total" do
  	ticket = Ticket.new(:id => 20, :date => "2015-02-01", :account_id => 0, :service_id => 0, :materialscost => 0.00, :labor => 50.00, :closed => true)
  	assert_raises(ActiveRecord::RecordInvalid) { ticket.save! }
  end

  test "new valid minimum" do
  	ticket = Ticket.new(:id => 21, :date => "2015-02-01", :account_id => 0, :service_id => 0, :materialscost => 0.00, :labor => 50.00, :total => 50.00, :closed => true)
  	assert_nothing_raised(ActiveRecord::RecordInvalid) { ticket.save! }

	  ticket.reload
  	assert_equal 21, ticket.id, "Did not recieve expected id from ticket after successful creation"
  	assert_equal "2015-02-01", ticket.date.to_s, "Did not recieve expected date from ticket after successful creation"
  	assert_equal 0, ticket.account_id, "Did not recieve expected account_id from ticket after successful creation"
  	assert_equal 0, ticket.service_id, "Did not recieve expected service_id from ticket after successful creation"
  	assert_nil ticket.materialslist, "Did not recieve expected materialslist from ticket after successful creation"
  	assert_in_delta 0.00, ticket.materialscost, 0.0001, "Did not recieve expected income from ticket after successful creation"
  	assert_in_delta 50.00, ticket.labor, 0.0001, "Did not recieve expected expense from ticket after successful creation"
  	assert_in_delta 50.00, ticket.total, 0.0001, "Did not recieve expected total from ticket after successful creation"
  	assert ticket.closed, "Did not recieve expected settled from ticket after successful creation"
  	assert_nil ticket.worklog, "Did not recieve expected notes from service after successful creation"
  end

  test "new valid maximum" do
  	ticket = Ticket.new(:id => 21, :date => "2015-02-01", :account_id => 0, :service_id => 0, :materialslist => "na", :materialscost => 0.00, :labor => 50.00, :total => 50.00, :closed => true, :worklog => "notes")
  	assert_nothing_raised(ActiveRecord::RecordInvalid) { ticket.save! }

  	ticket.reload
  	assert_equal 21, ticket.id, "Did not recieve expected id from ticket after successful creation"
  	assert_equal "2015-02-01", ticket.date.to_s, "Did not recieve expected date from ticket after successful creation"
  	assert_equal 0, ticket.account_id, "Did not recieve expected account_id from ticket after successful creation"
  	assert_equal 0, ticket.service_id, "Did not recieve expected service_id from ticket after successful creation"
  	assert_equal "na", ticket.materialslist, "Did not recieve expected materialslist from ticket after successful creation"
  	assert_in_delta 0.00, ticket.materialscost, 0.0001, "Did not recieve expected income from ticket after successful creation"
  	assert_in_delta 50.00, ticket.labor, 0.0001, "Did not recieve expected expense from ticket after successful creation"
  	assert_in_delta 50.00, ticket.total, 0.0001, "Did not recieve expected total from ticket after successful creation"
  	assert ticket.closed, "Did not recieve expected settled from ticket after successful creation"
  	assert_equal "notes", ticket.worklog, "Did not recieve expected notes from service after successful creation"
  end

  test "new dup id" do
  	ticket = Ticket.new(:id => 0, :date => "2015-02-01", :account_id => 0, :service_id => 0, :materialscost => 0.00, :labor => 50.00, :total => 50.00, :closed => true)
  	assert_raises(ActiveRecord::RecordInvalid) { ticket.save! }
  end

  test "new non-existent account_id" do
  	ticket = Ticket.new(:id => 20, :date => "2015-02-01", :account_id => 200, :service_id => 0, :materialslist => "na", :materialscost => 0.00, :labor => 50.00, :total => 50.00, :closed => true, :worklog => "notes")
  	assert_raises(ActiveRecord::RecordInvalid) { ticket.save! }
  end

  test "new non-numeric account_id" do
  	ticket = Ticket.new(:id => 20, :date => "2015-02-01", :account_id => "bad", :service_id => 0, :materialslist => "na", :materialscost => 0.00, :labor => 50.00, :total => 50.00, :closed => true, :worklog => "notes")
  	assert_raises(ActiveRecord::RecordInvalid) { ticket.save! }
  end

  test "new non-existent service_id" do
  	ticket = Ticket.new(:id => 20, :date => "2015-02-01", :account_id => 0, :service_id => 200, :materialslist => "na", :materialscost => 0.00, :labor => 50.00, :total => 50.00, :closed => true, :worklog => "notes")
  	assert_raises(ActiveRecord::RecordInvalid) { ticket.save! }
  end

  test "new non-numeric service_id" do
  	ticket = Ticket.new(:id => 20, :date => "2015-02-01", :account_id => 0, :service_id => "bad", :materialslist => "na", :materialscost => 0.00, :labor => 50.00, :total => 50.00, :closed => true, :worklog => "notes")
  	assert_raises(ActiveRecord::RecordInvalid) { ticket.save! }
  end

  test "new bad materialscost" do
  	ticket = Ticket.new(:id => 20, :date => "2015-02-01", :account_id => 0, :service_id => 0, :materialslist => "na", :materialscost => "bad", :labor => 50.00, :total => 50.00, :closed => true, :worklog => "notes")
  	assert_raises(ActiveRecord::RecordInvalid) { ticket.save! }
  end

  test "new bad labor" do
  	ticket = Ticket.new(:id => 20, :date => "2015-02-01", :account_id => 0, :service_id => 0, :materialslist => "na", :materialscost => 0.00, :labor => "bad", :total => 50.00, :closed => true, :worklog => "notes")
  	assert_raises(ActiveRecord::RecordInvalid) { ticket.save! }
  end

  test "new bad total" do
  	ticket = Ticket.new(:id => 20, :date => "2015-02-01", :account_id => 0, :service_id => 0, :materialslist => "na", :materialscost => 0.00, :labor => 50.00, :total => "bad", :closed => true, :worklog => "notes")
  	assert_raises(ActiveRecord::RecordInvalid) { ticket.save! }
  end

  test "new bad worklog" do
  	ticket = Ticket.new(:id => 20, :date => "2015-02-01", :account_id => 0, :service_id => 0, :materialslist => "na", :materialscost => 0.00, :labor => 50.00, :total => 50.00, :closed => true, :worklog => "abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890")
  	assert_raises(ActiveRecord::RecordInvalid) { ticket.save! }
  end


  ### Update Testing ###

  def setup
    unless @ticket.nil?
      @ticket.destroy!
    end
  	@ticket = Ticket.new(:id => 20, :date => "2015-02-01", :account_id => 0, :service_id => 0, :materialslist => "na", :materialscost => 0.00, :labor => 50.00, :total => 50.00, :closed => true, :worklog => "notes")
  	@ticket.save!
  	verify("before")
  end

  def verify(status)
  	@ticket.reload
  	assert_equal 20, @ticket.id, "Did not recieve expected id from ticket #{status} update"
  	assert_equal "2015-02-01", @ticket.date.to_s, "Did not recieve expected date from ticket #{status} update"
  	assert_equal 0, @ticket.account_id, "Did not recieve expected account_id from ticket #{status} update"
  	assert_equal 0, @ticket.service_id, "Did not recieve expected service_id from ticket #{status} update"
  	assert_equal "na", @ticket.materialslist, "Did not recieve expected materialslist from ticket #{status} update"
  	assert_in_delta 0.00, @ticket.materialscost, 0.0001, "Did not recieve expected income from ticket #{status} update"
  	assert_in_delta 50.00, @ticket.labor, 0.0001, "Did not recieve expected expense from ticket #{status} update"
  	assert_in_delta 50.00, @ticket.total, 0.0001, "Did not recieve expected total from ticket #{status} update"
  	assert @ticket.closed, "Did not recieve expected settled from ticket #{status} update"
  	assert_equal "notes", @ticket.worklog, "Did not recieve expected notes from service #{status} update"
  end

  test "update valid minimum" do
  	setup
  	assert_nothing_raised(ActiveRecord::RecordInvalid) {@ticket.update!(:id => 20, :date => "2015-02-01", :account_id => 0, :service_id => 0, :materialscost => 0.00, :labor => 50.00, :total => 50.00, :closed => true) }

	  @ticket.reload
  	assert_equal 20, @ticket.id, "Did not recieve expected id from ticket after successful creation"
  	assert_equal "2015-02-01", @ticket.date.to_s, "Did not recieve expected date from ticket after successful creation"
  	assert_equal 0, @ticket.account_id, "Did not recieve expected account_id from ticket after successful creation"
  	assert_equal 0, @ticket.service_id, "Did not recieve expected service_id from ticket after successful creation"
  	assert_equal "na", @ticket.materialslist, "Did not recieve expected materialslist from ticket after successful creation"
  	assert_in_delta 0.00, @ticket.materialscost, 0.0001, "Did not recieve expected income from ticket after successful creation"
  	assert_in_delta 50.00, @ticket.labor, 0.0001, "Did not recieve expected expense from ticket after successful creation"
  	assert_in_delta 50.00, @ticket.total, 0.0001, "Did not recieve expected total from ticket after successful creation"
  	assert @ticket.closed, "Did not recieve expected settled from ticket after successful creation"
  	assert_equal "notes", @ticket.worklog, "Did not recieve expected notes from service after successful creation"
  end

  test "update valid maximum" do
  	setup
  	assert_nothing_raised(ActiveRecord::RecordInvalid) {@ticket.update!(:id => 20, :date => "2015-02-01", :account_id => 0, :service_id => 0, :materialslist => "na", :materialscost => 0.00, :labor => 50.00, :total => 50.00, :closed => true, :worklog => "notes") }

  	@ticket.reload
  	assert_equal 20, @ticket.id, "Did not recieve expected id from ticket after successful creation"
  	assert_equal "2015-02-01", @ticket.date.to_s, "Did not recieve expected date from ticket after successful creation"
  	assert_equal 0, @ticket.account_id, "Did not recieve expected account_id from ticket after successful creation"
  	assert_equal 0, @ticket.service_id, "Did not recieve expected service_id from ticket after successful creation"
  	assert_equal "na", @ticket.materialslist, "Did not recieve expected materialslist from ticket after successful creation"
  	assert_in_delta 0.00, @ticket.materialscost, 0.0001, "Did not recieve expected income from ticket after successful creation"
  	assert_in_delta 50.00, @ticket.labor, 0.0001, "Did not recieve expected expense from ticket after successful creation"
  	assert_in_delta 50.00, @ticket.total, 0.0001, "Did not recieve expected total from ticket after successful creation"
  	assert @ticket.closed, "Did not recieve expected settled from ticket after successful creation"
  	assert_equal "notes", @ticket.worklog, "Did not recieve expected notes from service after successful creation"
  end

  test "update non-existent account_id" do
  	setup
  	assert_raises(ActiveRecord::RecordInvalid) {@ticket.update!(:date => "2015-02-01", :account_id => 200, :service_id => 0, :materialslist => "na", :materialscost => 0.00, :labor => 50.00, :total => 50.00, :closed => true, :worklog => "notes") }
  	verify("after")
  end

  test "update non-numeric account_id" do
  	setup
  	assert_raises(ActiveRecord::RecordInvalid) {@ticket.update!(:date => "2015-02-01", :account_id => "bad", :service_id => 0, :materialslist => "na", :materialscost => 0.00, :labor => 50.00, :total => 50.00, :closed => true, :worklog => "notes") }
  	verify("after")
  end

  test "update non-existent service_id" do
  	setup
  	assert_raises(ActiveRecord::RecordInvalid) {@ticket.update!(:date => "2015-02-01", :account_id => 0, :service_id => 200, :materialslist => "na", :materialscost => 0.00, :labor => 50.00, :total => 50.00, :closed => true, :worklog => "notes") }
  	verify("after")
  end

  test "update non-numeric service_id" do
  	setup
  	assert_raises(ActiveRecord::RecordInvalid) {@ticket.update!(:date => "2015-02-01", :account_id => 0, :service_id => "bad", :materialslist => "na", :materialscost => 0.00, :labor => 50.00, :total => 50.00, :closed => true, :worklog => "notes") }
  	verify("after")
  end

  test "update bad materialscost" do
  	setup
  	assert_raises(ActiveRecord::RecordInvalid) {@ticket.update!(:date => "2015-02-01", :account_id => 0, :service_id => 0, :materialslist => "na", :materialscost => "bad", :labor => 50.00, :total => 50.00, :closed => true, :worklog => "notes") }
  	verify("after")
  end

  test "update bad labor" do
  	setup
  	assert_raises(ActiveRecord::RecordInvalid) {@ticket.update!(:date => "2015-02-01", :account_id => 0, :service_id => 0, :materialslist => "na", :materialscost => 0.00, :labor => "bad", :total => 50.00, :closed => true, :worklog => "notes") }
  	verify("after")
  end

  test "update bad total" do
  	setup
  	assert_raises(ActiveRecord::RecordInvalid) {@ticket.update!(:date => "2015-02-01", :account_id => 0, :service_id => 0, :materialslist => "na", :materialscost => 0.00, :labor => 50.00, :total => "bad", :closed => true, :worklog => "notes") }
  	verify("after")
  end

  test "update bad worklog" do
  	setup
  	assert_raises(ActiveRecord::RecordInvalid) {@ticket.update!(:date => "2015-02-01", :account_id => 0, :service_id => 0, :materialslist => "na", :materialscost => 0.00, :labor => 50.00, :total => 50.00, :closed => true, :worklog => "abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890abcdefghijklmnopqrstuvwxyz1234567890") }
  	verify("after")
  end

  ### Read Testing ###

  test "read ticket1" do
	ticket1 = Ticket.find(0)
  	assert_equal 0, ticket1.id, "Did not recieve expected id from ticket1"
  	assert_equal "2015-01-27", ticket1.date.to_s, "Did not recieve expected date from ticket1"
  	assert_equal 0, ticket1.account_id, "Did not recieve expected account_id from ticket1"
  	assert_equal 0, ticket1.service_id, "Did not recieve expected ticket_id from ticket1"
  	assert_nil ticket1.materialslist, "Did not recieve expected notes from ticket1"
  	assert_in_delta 0.00, ticket1.materialscost, 0.0001, "Did not recieve expected income from ticket1"
  	assert_in_delta 60.00, ticket1.labor, 0.0001, "Did not recieve expected expense from ticket1"
  	assert_in_delta 60.00, ticket1.total, 0.0001, "Did not recieve expected total from ticket1"
  	assert ticket1.closed, "Did not recieve expected closed value from ticket1"
  	assert_equal "Basic consulting work.", ticket1.worklog, "Did not recieve expected worklog from ticket1"
  end
end
