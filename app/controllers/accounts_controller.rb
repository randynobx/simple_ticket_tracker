class AccountsController < ApplicationController
  def index
    @accounts = Account.where(params.permit(:category, :business, :city, :state, :zip))
  end

  def show
      begin
        @account = Account.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        raise("Account not found.")
      end

      @ticket_count = Ticket.where(account_id: @account.id).count
      @ticket_income = Ticket.where(account_id: @account.id).sum(:labor)
  end

  def new
    @account = Account.new
  end

  def create
    begin
      @account = Account.new(account_params)
    rescue ActiveRecord::RecordNotFound => e
      raise("Account not found.")
    end
    
    if @account.save!
      redirect_to @account
    else
      render 'new'
    end
  end

  def edit
    begin
      @account = Account.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      raise("Account not found.")
    end
  end

  def update
    begin
      @account = Account.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      raise("Account not found.")
    end

    if @account.update!(account_params)
      redirect_to @account
    else
      render 'edit'
    end
  end

  private
    def account_params
      params.require(:account).permit(:id, :category, :name, :business, :phone, :email, :address, :city, :state, :zip, :notes)
    end
end