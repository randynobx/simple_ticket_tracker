class RecordsController < ApplicationController
  def index
    @records = Record.all
  end

  def show
    @record = Record.find(params[:id])
    @account = Account.find(@record.account_id)
  end

  def new
    @record = Record.new
  end

  def create
  	@record = Record.new(record_params)
    
    if @record.save
      redirect_to @record
    else
      render 'new'
    end
  end

  def edit
    @record = Record.find(params[:id])
  end

  def update
    @record = Record.find(params[:id])

    if @record.update(record_params)
      redirect_to @record
    else
      render 'edit'
    end
  end

  def destroy
    @record = Record.find(params[:id])
    @record.destroy

    redirect_to records_path
  end

  private
    def record_params
      params.require(:record).permit(:id, :date, :account_id, :ticket_id, :income, :expense, :total, :settled, :notes)
    end
end
