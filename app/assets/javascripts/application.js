// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require rails-ujs
//= require activestorage
//= require chosen-jquery
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .
$(document).on('turbolinks:load', function() {
  if(localStorage.getItem("role_type")){
    $("#user_type").val(localStorage.getItem("role_type"))
  }
  else{
    userType = $("#user_type option:selected").val();
  }  
  $('#user_type').change(function(){
    userType = $(this).val();
    localStorage.setItem("role_type", userType)
    $('#user_role_id').val(localStorage.getItem("role_type"))
  });
  $('#credit_score_val').text($('#borrower_request_credit_score').val())
  $('.credit_score').change(function(){
    $('#credit_score_val').text($(this).val())
  });   
  //google place autocomplete
  var areas = []    //{place: "Udaipur, Rajasthan ,India", latitude: 2.13456456, longitude: 32.5456 , city: , state: , country: }
    var area_input = document.getElementById('gmaps-input-address');
  var options = {
    types: ['(cities)']
  };
  var autocomplete = new google.maps.places.Autocomplete(area_input, options);
  google.maps.event.addListener(autocomplete, 'place_changed', function() {
    var place = autocomplete.getPlace();
    place_name = place["name"]
    place_id = place["place_id"]
    $('#gmaps-input-address').val(place_name);
    var geocoder = new google.maps.Geocoder();    
    if (geocoder) {
      geocoder.geocode({
        'placeId': place_id
      }, function (results, status) {
          if (status == google.maps.GeocoderStatus.OK) {
            latitude = results[0].geometry.location.lat();
            longitude = results[0].geometry.location.lng();
            $('.area_select').val("")
            var loc = place.address_components
            areas.push({"place": place.formatted_address, "latitude": latitude, "longitude": longitude,"city": loc[0].short_name, "state":loc[loc.length-2].long_name,"country":loc[loc.length-1].long_name })       
            $('.area_select_val').val(JSON.stringify(areas)).serialize()
            $('.areas').append("<div class='tags'> <span >" + place.formatted_address+"</span><button type='button' class='close' aria-label='Close'><span class='tag_remove' onclick='remove_tag($(this));' aria-hidden='true'>&times;</span></button></div>")
          }else{
            console.log("error")
          }
      });
    }
  });
    //for address
    var places = []
    var address_input, address_autocomplete, address_options;

    address_input = document.getElementById('address-input');

    address_options = {
      types: ['geocode']
    };
    var components = {
      locality: 'long_name',
      administrative_area_level_1: 'long_name',
      country: 'long_name',
    };
    address_autocomplete = new google.maps.places.Autocomplete(address_input, address_options);

    google.maps.event.addListener(address_autocomplete, 'place_changed', function() {
      var geocoder, place, place_id, place_name;
      place = address_autocomplete.getPlace();
      console.log(place)
      place_name = place.formatted_address;
      place_id = place['place_id'];
      $('#address-input').val(place_name);
      geocoder = new google.maps.Geocoder;     
      if (geocoder) {
        geocoder.geocode({
          'placeId': place_id
        }, function(results, status) {
          var latitude, longitude;
          if (status === google.maps.GeocoderStatus.OK) {
            latitude = results[0].geometry.location.lat();
            longitude = results[0].geometry.location.lng();
            var loc = place.address_components
            $('#borrower_request_latitude').val(latitude)
            $('#borrower_request_longitude').val(longitude)
            var city='', state='' , country='';            
            for (var i = 0; i < place.address_components.length; i++) {
              var addressType = place.address_components[i].types[0]; 
              if (components[addressType]) {
                if(addressType == 'locality'){
                  city = place.address_components[i][components[addressType]];
                }
                else if(addressType == 'administrative_area_level_1'){
                  state = place.address_components[i][components[addressType]];
                }
                else if(addressType == 'country'){
                  country = place.address_components[i][components[addressType]];
                }                
              }              
            }
            places.push({"city": city, "state": state,"country": country})
            $('.place_select_val').val(JSON.stringify(places)).serialize()           
          } else {
            console.log('error');
          }
        });
      }
    });  
    //for address end 
});

//remove tags from slected areas
  function remove_tag(p){
    p.parent().closest("div").remove();
  }