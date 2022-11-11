class PhLocationService
  attr_reader :url

  def initialize
    @url = 'https://psgc.gitlab.io/api'
  end

  def fetch_region
    request = RestClient.get("#{url}/regions/")
    data = JSON.parse(request.body)
    data.each do |region|
      address_region = Address::Region.find_or_initialize_by(code: region['code'])
      address_region.name = region['regionName']
      address_region.save
    end
  end

  def fetch_province
    request = RestClient.get("#{url}/provinces")
    data = JSON.parse(request.body)
    data.each do |province|
      address_province = Address::Province.find_or_initialize_by(code: province['code'])
      region = Address::Region.find_by_code(province['regionCode'])
      address_province.region = region
      address_province.name = province['name']
      address_province.save
    end
  end

  def fetch_district
    request = RestClient.get("#{url}/districts/")
    data = JSON.parse(request.body)
    data.each do |district|
      address_district = Address::District.find_or_initialize_by(code: district['code'])
      region = Address::Region.find_by_code(district['regionCode'])
      province = Address::Province.find_by_code(district['regionCode'])
      address_district.region = region
      address_district.province = province
      address_district.name = district['name']
      address_district.save
    end
  end


end