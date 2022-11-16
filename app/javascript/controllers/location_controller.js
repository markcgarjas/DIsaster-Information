import {Controller} from "@hotwired/stimulus"


export default class extends Controller {
  static targets = ["selectRegionId", "selectProvinceId","selectCityMunicipalityId","selectBarangayId"]

  fetchProvinces() {
    let target = this.selectProvinceIdTarget
    $(target).empty();
    $.ajax({
      type: 'GET',
      url: '/api/regions/' + this.selectRegionIdTarget.value + '/provinces',
      dataType: 'json',
      success: (response) => {
        $.each(response, function (index, record) {
          console.log(record.name)
          console.log(record.id)
          let option = document.createElement('option')
          option.value = record.id
          option.text = record.name
          target.appendChild(option)
        })
      }
    })
  }

  fetchCityMunicipalities() {
      let target = this.selectCityMunicipalityIdTarget
      $(target).empty();
      $.ajax({
        type: 'GET',
        url: '/api/regions/' + this.selectRegionIdTarget.value + '/provinces/' + this.selectProvinceIdTarget.value + '/city_municipalities',
        dataType: 'json',
        success: (response) => {
          $.each(response, function (index, record) {
            console.log(record.name)
            console.log(record.id)
            let option = document.createElement('option')
            option.value = record.id
            option.text = record.name
            target.appendChild(option)
          })
        }
      })
    }

    fetchBarangays() {
          let target = this.selectBarangayIdTarget
          $(target).empty();
          $.ajax({
            type: 'GET',
            url: '/api/regions/' + this.selectRegionIdTarget.value + '/provinces/' + this.selectProvinceIdTarget.value + '/city_municipalities/' + this.selectCityMunicipalityIdTarget.value + '/barangays',
            dataType: 'json',
            success: (response) => {
              $.each(response, function (index, record) {
                console.log(record.name)
                console.log(record.id)
                let option = document.createElement('option')
                option.value = record.id
                option.text = record.name
                target.appendChild(option)
              })
            }
          })
        }

}