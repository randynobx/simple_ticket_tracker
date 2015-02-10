class DashboardController < ApplicationController
  def index
  	# Calculate statistics
  	@total_income = Record.sum(:income)
	@total_expense = Record.sum(:expense)
	@total_net = Record.sum(:total))
	@total_income = Record.sum(:total)
	@top_ticket = Account.find_by(id: Ticket.group(:account_id).count.max{|a, b| a.last <=> b.last}.first)
	@top_revenue = Account.find_by(id: Record.group(:account_id).sum(:total).max.first)
	@unsettled_income = Record.where(settled: false).sum(:income))
	@unsettled_expense = Record.where(settled: false).sum(:expense))
	@unsettled_net = Record.where(settled:false).sum(:total))
  end
end