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

  def destroy
    begin
      @account = Account.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      raise("Account not found.")
    end
    
    Ticket.where(account_id: @account.id).each do |t|
      t.destroy!
    end
    @account.destroy!

    redirect_to accounts_path
  end

  private
    def account_params
      params.require(:account).permit(:id, :category, :name, :business, :phone, :email, :address, :city, :state, :zip, :notes)
    end
end