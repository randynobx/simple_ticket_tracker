class TicketsController < ApplicationController

  def index
    @tickets = Ticket.where(params.permit(:account_id, :service_id))
  end

  def show
    @ticket = Ticket.find(params[:id])
    @account = Account.find(@ticket.account_id)
    @service = Service.find(@ticket.service_id)
    @records = Record.find_by(ticket_id: @ticket.id)
  end

  def new
  	@ticket = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_params)

    if @ticket.save
      redirect_to @ticket
    else
      render 'new'
    end
  end

  def edit
    @ticket = Ticket.find(params[:id])
  end

  def update
    @ticket = Ticket.find(params[:id])

    if @ticket.update(ticket_params)
      redirect_to @ticket
    else
      render 'edit'
    end
  end

  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy

    redirect_to tickets_path
  end

  private
    def ticket_params
      params.require(:ticket).permit(:id, :date, :account_id, :service_id, :materialslist, :materialscost, :labor, :total, :closed, :worklog)
    end

    def record_params
      params.require(:ticket).permit(:date, account_id: @ticket.account_id, ticket_id: @ticket.id, income: @ticket.total, expense: @ticket.materialscost, settled: @ticket.closed)
    end
end
