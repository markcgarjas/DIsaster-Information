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
      address_district.region = region
      address_district.name = district['name']
      address_district.save
    end
  end

  def fetch_city_municipality
    request = RestClient.get("#{url}/cities-municipalities/")
    data = JSON.parse(request.body)
    data.each do |city_municipality|
      address_city_municipality = Address::CityMunicipality.find_or_initialize_by(code: city_municipality['code'])
      region = Address::Region.find_by_code(city_municipality['regionCode'])
      province = Address::Province.find_by_code(city_municipality['provinceCode'])
      district = Address::District.find_or_initialize_by(code: city_municipality['districtCode'])
      address_city_municipality.region = region
      address_city_municipality.province = province
      address_city_municipality.district = district
      address_city_municipality.name = city_municipality['name']
      address_city_municipality.save
    end
  end

  def fetch_barangay
    request = RestClient.get("#{url}/barangays/")
    data = JSON.parse(request.body)
    data.each do |barangay|
      address_barangay = Address::Barangay.find_or_initialize_by(code: barangay['code'])
      city_municipality = Address::CityMunicipality.find_or_initialize_by(code: barangay['code'])
      district = Address::District.find_or_initialize_by(code: barangay['code'])
      region = Address::Region.find_by_code(barangay['regionCode'])
      province = Address::Province.find_by_code(barangay['regionCode'])
      address_barangay.region = region
      address_barangay.province = province
      address_barangay.district = district
      address_barangay.city_municipality = city_municipality
      address_barangay.name = barangay['name']
      address_barangay.save
    end
  end

end