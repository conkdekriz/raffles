class PricesController < ApplicationController 
layout 'rifa'
  def index
    @prices = Price.all
  end
  
  def create
    price = Price.create!(price_params(params))
    flash.alert = 'Ingresado con éxito' if price
    redirect_to new_price_path
  end
  
  def new

  end

  private

  def price_params(params)
    params.require(:price).permit(
      :name,
      :number,
      :rrss,
      :description
    )
  end
end