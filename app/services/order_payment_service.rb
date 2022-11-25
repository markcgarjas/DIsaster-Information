class OrderPaymentService
  attr_reader :url, :secret_key, :merchant_id, :notify

  Request_Content_Type = 'application/x-www-form-urlencoded;charset=utf-8'

  def initialize
    @url = 'https://gem-camp-api.tinyuri.net'
    @secret_key = '475552979105c21940a6c793d871d05d3c506565'
    @merchant_id = 'G42Fuyfn3hYeY9d0obulvw'
    @notify = 'https://localhost:3000/top_ups/callback'
  end

  def merchant
    params = {
      merchant_id: merchant_id
    }
    params[:token] = generate_token_merchant
    params[:exp] = token_expiration
    raw_response = RestClient.post "#{url}/api/v1/merchant/balance",
                                   generate_query_string(params),
                                   { 'Content-Type': Request_Content_Type }
    JSON.parse(raw_response.body)
  rescue RestClient::Forbidden => e
    e.response.body
  end

  def deposit(order)
    params = {
      merchant_id: merchant_id,
      username: order.user.email,
      amount: order.amount,
      serial_number: order.serial_number,
      notify_url: notify,
    }
    params[:token] = generate_token_merchant
    params[:exp] = token_expiration
    raw_response = RestClient.post "#{url}/api/v1/transactions/deposit",
                                   generate_query_string(params),
                                   {
                                     'Content-Type': Request_Content_Type
                                   }
    JSON.parse(raw_response)
  rescue RestClient::Forbidden => e
    e.response.body
  end

  def withdraw(order)
    params = {
      merchant_id: merchant_id,
      username: order.user.email,
      amount: order.amount,
      serial_number: order.serial_number,
      notify_url: notify,
      bank_name: order.bank_name,
      bank_card_number: order.bank_card_number,
      bank_real_name: order.bank_real_name
    }
    params[:token] = generate_token_merchant
    params[:exp] = token_expiration
    raw_response = RestClient.post "#{url}/api/v1/transactions/withdraw?#{generate_query_string(params)}",
                                   {
                                     'Content-Type': Request_Content_Type
                                   }
    JSON.parse(raw_response)
  rescue RestClient::Forbidden => e
    e.response.body
  end

  def order_status(order)
    params = {
      merchant_id: merchant_id,
      serial_number: order.serial_number
    }
    params[:token] = generate_token_merchant
    params[:exp] = token_expiration
    raw_response = RestClient.get("#{url}/api/v1/transaction_status?#{generate_query_string(params)}")
    JSON.parse(raw_response)
  rescue RestClient::Forbidden => e
    e.response.body
  end

  def generate_token_merchant
    params = {
      merchant_id: merchant_id
    }
    token = JWT.encode(params, @secret_key, 'HS512')
    Base64.urlsafe_encode64(token)
  end

  def token_expiration
    Time.current.to_i + 2000
  end

  def generate_query_string(params)
    params.to_query
  end
end