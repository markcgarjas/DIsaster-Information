class OrderPaymentService
  attr_reader :url, :secret_key, :merchant_id, :datetime, :errors, :token_exp

  Request_Content_Type = 'application/x-www-form-urlencoded;charset=utf-8'

  def initialize
    @url = 'https://gem-camp-api.tinyuri.net'
    @secret_key = '475552979105c21940a6c793d871d05d3c506565'
    @merchant_id = 'G42Fuyfn3hYeY9d0obulvw'
    @datetime = DateTime.current.strftime('%Y%m%d%H%M%S')
    @errors = {}
    @token_exp = Time.current.to_i + 2000
  end

  def merchant
    params = {
      merchant_id: merchant_id,
      exp: token_exp
    }
    params[:token] = generate_token_merchant
    raw_response = RestClient.post "#{url}/api/v1/merchant/balance",
                                   generate_query_string(params),
                                   { 'Content-Type': Request_Content_Type }
    JSON.parse(raw_response)
  rescue RestClient::Forbidden => e
    e.response.body
  end

  def deposit

  end

  def generate_token_merchant
    params = {
      merchant_id: merchant_id,
      exp: token_exp
    }
    token = JWT.encode(params, @secret_key, 'HS512')
    Base64.urlsafe_encode64(token)
  end

  def auth_token
    params = {
      merchant_id: merchant_id,
      datetime: datetime
    }
    params[:signature] = sign(params, key)
    raw_response = RestClient.post "#{url}/api/v1/merchant/balance",
                                   generate_query_string(params),
                                   {
                                     'Content-Type': Request_Content_Type
                                   }
    JSON.parse(raw_response)['data']['auth_token']
  end

  def sign(params, key)
    Digest::MD5.hexdigest((params.values << key).join).downcase
  end

  def generate_query_string(params)
    params.to_query
  end

  def validate_response(response)
    @errors = {}
    if response['code'] == '0'
      true
    else
      @errors['msg'] = response['message']
      @errors['success'] = 'false'
      false
    end
  end
end