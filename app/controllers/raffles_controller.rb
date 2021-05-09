class RafflesController < ApplicationController 
  before_action :set_raffles, only: %i[edit update]

  layout 'rifa'
  def index
    @raffles = Raffle.where(paid: 'completed')
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
    url = ENV['PAID_URL']
    puts url
    # nimrod.avispa.work
    require 'json'
    numbers = JSON.parse(raffle_params(params)[:number])
    code = "rifacamila#{numbers.join("")}"
    numbers.each do |number|
      return redirect_to raffles_path unless Raffle.find_by(number: number).nil?
      Raffle.create!(name: raffle_params(params)[:name], 
                    phone: raffle_params(params)[:phone],
                    mail: raffle_params(params)[:mail],
                    number: number,
                    code: code)
      
    end
    amount = ((numbers.count) * 1000).to_i
    
    work = "Pago Rifa"
    detail = "Pago por los siguientes números #{numbers.join(" ")}"
    url_response = "#{ENV['RESPONSE_URL']}#{code}/response_paid"
    payload = pay_payload(code, amount, work, detail, url_response)
    headers = {
      'X-API-TOKEN' => ENV['API_TOKEN'],
      'Content-Type' => 'application/json'
    }.freeze
    processed_payload = Oj.dump(payload.deep_stringify_keys)
    Rails.logger.debug processed_payload
   
    request = Typhoeus.post(url, body: processed_payload, headers: headers)

    resp = JSON.parse(request.body).deep_symbolize_keys
    redirect_to resp.dig(:data, :attributes, :url)
  end

  def response_paid
    raffles = Raffle.where(code: params["id"])
    raffles.each do |raffle|
      raffle.update('paid': 'completed')
    end
    redirect_to gracias_raffles_path
  end

  # Parameters: 
  # {
  #   "data"=>
  #     {"id"=>"6364", "type"=>"Payment", 
  #   "attributes"=>
  #     {"title"=>"Pago Rifa", 
  #       "detail"=>"Pago por los siguientes números 63 64", 
  #       "total_amount"=>"2000", 
  #       "purchase_order"=>"6364", 
  #       "pay_date"=>"2021-04-30 15:18:21 UTC", 
  #       "card_number"=>"XXXX-XXXX-XXXX-7763", 
  #       "shares_number"=>"0", 
  #       "authorization_code"=>"1415", 
  #       "payment_method_name"=>"Venta Débito.", 
  #       "status"=>"completed"}}, 
  #     "id"=>"6364"}
    
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
  def pay_payload(code,amount,work,detail, url_response)
    payload =
      {
        data: {
          id: code,
          type: "PadpowCharge",
          attributes: {
            amount_cents: amount,
            work: work,
            detail: detail,
            reference_code: code
          }
        },
        links:{
          return_url: url_response
        }
      }
    payload
  end
  
end