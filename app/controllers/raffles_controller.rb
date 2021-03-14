class RafflesController < ApplicationController 
  layout 'rifa'
  def index
    @raffles = Raffle.all
  end

  def new
    Rails.logger.info params.inspect
    @number = params[:number]
  end
  
  def create
    raffle = Raffle.create!(raffle_params(params))
    flash.alert = 'Ingresado con éxito' if raffle
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