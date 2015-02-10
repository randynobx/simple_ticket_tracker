class ServicesController < ApplicationController
  def index
    @services = Service.all
  end

  def show
    begin
      @service = Service.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      raise("Service not found")
    end
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.new(service_params)
    
    if @service.save!
      redirect_to @service
    else
      render 'new'
    end
  end

  def edit
    begin
      @service = Service.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      raise("Service not found")
    end
  end

  def update
    begin
      @service = Service.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      raise("Service not found")
    end

    if @service.update!(service_params)
      redirect_to @service
    else
      render 'edit'
    end
  end

  private
    def service_params
      params.require(:service).permit(:id, :category, :price, :rate)
    end
end