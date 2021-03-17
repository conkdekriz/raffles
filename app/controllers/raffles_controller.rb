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
    @number

  end
  def paid
    @raffles = Raffle.all.order(number: :desc)
  end
  
  def create
    require 'json'
    @file = ''
    JSON.parse(raffle_params(params)[:number]).each do |number|
      uploaded_io = raffle_params(params)[:comprobante]

      File.open(Rails.root.join('public', 'uploads', uploaded_io), 'wb') do |file|
        @file = "/public/uploads/#{uploaded_io}"
      end

      Raffle.create!(name: raffle_params(params)[:number], 
                    phone: raffle_params(params)[:phone],
                    mail: raffle_params(params)[:email],
                    number: number,
                    file: @file)
      
    end
    flash.alert = 'Ingresado con éxito'
    redirect_to raffles_path
  end
    
  private

  def raffle_params(params)
    params.require(:raffle).permit(
      :name,
      :phone,
      :email,
      :number,
      :comprobante
    )
  end
end