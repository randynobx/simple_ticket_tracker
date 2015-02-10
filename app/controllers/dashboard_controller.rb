class DashboardController < ApplicationController
  def index
  	# Account statistics
  	@top_ticket = Account.find_by(id: Ticket.group(:account_id).count.max{|a, b| a.last <=> b.last}.first)
	@top_revenue = Account.find_by(id: Record.group(:account_id).sum(:total).max.first)
  	
  	# Record statistics
  	@total_income = Record.sum(:income)
	@total_expense = Record.sum(:expense)
	@total_net = Record.sum(:total)
	@unsettled_income = Record.where(settled: false).sum(:income)
	@unsettled_expense = Record.where(settled: false).sum(:expense)
	@unsettled_net = Record.where(settled:false).sum(:total)
	
	# Ticket Statistics
	@unpaid_tickets = Ticket.where(closed: false).sum(:total)

	# Records and Tickets for listing
	@tickets = Ticket.where(closed: false)
	@records = Record.where(settled: false)
  end
end