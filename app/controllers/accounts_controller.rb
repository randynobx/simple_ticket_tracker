class AccountsController < ApplicationController
  def index
    @accounts = Account.all
  end

  def show
    @account = Account.find(params[:id])
  end

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(account_params)
    
    if @account.save
      redirect_to @account
    else
      render 'new'
    end
  end

  def edit
    @account = Account.find(params[:id])
  end

  def update
    @account = Account.find(params[:id])

    if @account.update(account_params)
      redirect_to @account
    else
      render 'edit'
    end
  end

  def destroy
    @account = Account.find(params[:id])
    Ticket.where(account_id: @account.id).each do |t|
      t.destroy
    end
    @account.destroy

    redirect_to accounts_path
  end

  private
    def account_params
      params.require(:account).permit(:id, :category, :name, :business, :phone, :email, :address, :city, :state, :zip, :notes)
    end
end