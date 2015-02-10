class RecordsController < ApplicationController
  def index
    @records = Record.where(params.permit(:account_id, :ticket_id, :settled))
  end

  def show
    begin
      @record = Record.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      raise("Record not found")
    end

    begin
      @account = Account.find(@record.account_id)
    rescue ActiveRecord::RecordNotFound => e
      raise("Account not found")
      
    end
  end

  def new
    @record = Record.new(params.permit(:account_id, :ticket_id))
  end

  def create
  	@record = Record.new(record_params)
    
    if @record.save!
      redirect_to @record
    else
      render 'new'
    end
  end

  def edit
    begin
      @record = Record.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      raise("Record not found")
    end
  end

  def update
    begin
      @record = Record.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      raise("Record not found")
    end

    if @record.update!(record_params)
      redirect_to @record
    else
      render 'edit'
    end
  end

  private
    def record_params
      params.require(:record).permit(:id, :date, :account_id, :ticket_id, :income, :expense, :total, :settled, :notes)
    end
end
