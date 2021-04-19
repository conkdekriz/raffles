class RafflesController < ApplicationController 
  before_action :set_raffles, only: %i[edit update]
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
    @raffles = Raffle.all.order(number: :asc)
  end
  
  def create
    require 'json'
    @file = ''
    JSON.parse(raffle_params(params)[:number]).each do |number|
      uploaded_io = raffle_params(params)[:comprobante]
      File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'w') do |file|
        file.write(uploaded_io.read.force_encoding(Encoding::UTF_8))
        @file = "uploads/#{uploaded_io.original_filename}"
      end      

      Raffle.create!(name: raffle_params(params)[:name], 
                    phone: raffle_params(params)[:phone],
                    mail: raffle_params(params)[:mail],
                    number: number,
                    file: @file)
      
    end
    flash.alert = 'Ingresado con éxito'
    redirect_to gracias_path
  end
    
  def edit;
  end

  def update
    Raffle.find(@raffle.id).update(raffle_params(params))
    redirect_to paid_raffles_path
  end

  def gracias

  end

  def destroy
    Raffle.delete(params["id"])
    redirect_to paid_raffles_path
  end

  private

  def raffle_params(params)
    params.require(:raffle).permit(
      :name,
      :phone,
      :mail,
      :number,
      :comprobante
    )
  end
  def set_raffles
    @raffle = Raffle.find(params[:id])
  end
end