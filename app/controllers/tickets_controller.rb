class TicketsController < ApplicationController
  def index
    @tickets = Ticket.where(params.permit(:account_id, :service_id, :closed))
  end

  def show
    begin
      @ticket = Ticket.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      raise("Ticket not found")  
    end
    
    begin
      @account = Account.find(@ticket.account_id)
    rescue ActiveRecord::RecordNotFound => e
      raise("The account linked to this ticket was not found. Ticket may be corrupted.")
    end

    begin
      @service = Service.find(@ticket.service_id)
    rescue ActiveRecord::RecordNotFound => e
      raise("The service linked to this ticket was not found. Ticket may be corrupted.")
    end

    @records = Record.where(ticket_id: @ticket.id)
  end

  def new
  	@ticket = Ticket.new(params.permit(:account_id, :service_id))
  end

  def create
    @ticket = Ticket.new(ticket_params)

    if @ticket.save!
      redirect_to @ticket
    else
      render 'new'
    end
  end

  def edit
    begin
      @ticket = Ticket.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      raise("Ticket not found")
    end
  end

  def update
    begin
      @ticket = Ticket.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      raise("Ticket not found")
    end

    if @ticket.update!(ticket_params)
      redirect_to @ticket
    else
      render 'edit'
    end
  end

  private
    def ticket_params
      params.require(:ticket).permit(:id, :date, :account_id, :service_id, :materialslist, :materialscost, :labor, :total, :closed, :worklog)
    end

    def record_params
      params.require(:ticket).permit(:date, account_id: @ticket.account_id, ticket_id: @ticket.id, income: @ticket.total, expense: @ticket.materialscost, settled: @ticket.closed)
    end
end
