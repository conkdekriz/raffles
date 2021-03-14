class RafflesController < ApplicationController 
  layout 'rifa'
  def index
    @raffles = Raffle.all
  end

  def new
    Rails.logger.info params.inspect
    @number = []
    params[:number].each do |num, sta|
      @number << num
    end
    Rails.logger.info @number
    @number

  end
  
  def create
    require 'json'
    JSON.parse(raffle_params(params)[:number]).each do |number|
      Raffle.create!(name: raffle_params(params)[:number], 
                    phone: raffle_params(params)[:phone],
                    mail: raffle_params(params)[:mail],
                    number: number)
    end
    flash.alert = 'Ingresado con éxito'
    redirect_to raffles_path
  end
    
  private

  def raffle_params(params)
    params.require(:raffle).permit(
      :name,
      :phone,
      :mail,
      :number
    )
  end
end