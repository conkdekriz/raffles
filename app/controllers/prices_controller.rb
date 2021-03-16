class PricesController < ApplicationController 
before_action :set_prices, only: %i[edit update]
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

  def edit;
  end

  def update
    Price.find(@price.id).update(price_params(params))
    redirect_to all_prices_path
  end

  def all
    @prices = Price.all
  end
  private

  def set_prices
    @price = Price.find(params[:id])
  end

  def price_params(params)
    params.require(:price).permit(
      :name,
      :number,
      :rrss,
      :description
    )
  end
end