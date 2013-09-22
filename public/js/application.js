// google.maps.event.addDomListener(window, 'load', initialize);

var geocoder;
var map;
var dbc;
function initialize() {
  geocoder = new google.maps.Geocoder();
  var dbc = new google.maps.LatLng(41.88991, -87.63766);
  var mapOptions = {
    zoom: 17,
    center: dbc,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }
  map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
  
  var marker = new google.maps.Marker({
      position: dbc,
      map: map,
      title: 'Hello World!'
  });
  
  infowindow = new google.maps.InfoWindow({ maxWidth: 320 }); 
}

function codeAddress(address, restaurant) {
  geocoder.geocode( { 'address': address}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      lat = results[0].geometry.location.ob;
      lng = results[0].geometry.location.pb;
      html = "<b>" + restaurant.name + "</b>" + "  - $" + 
              restaurant.avg_price + "<br>" + 
              restaurant.food_type + "<br><br>" +
              restaurant.address 
              ;
      setMarker(lat, lng, html);
    } else {
      alert('Geocode was not successful for the following reason: ' + status);
    }
  });
}

function setMarker(lat, lon, html) {
  var latLng = new google.maps.LatLng(lat, lon);
  var marker = new google.maps.Marker({
    position: latLng,
    map: map,
    data: html
  });
  
  google.maps.event.addListener(marker, 'click', function() { 
    map.setCenter(new google.maps.LatLng(marker.position.lat(), marker.position.lng())); 
    map.setZoom(16); 
    onItemClick(event, marker); 
  }); 
}

function onItemClick(event, pin) { 
  // Create content
  var contentString = pin.data
  // Replace our Info Window's content and position 
  infowindow.setContent(contentString); 
  infowindow.setPosition(pin.position); 
  infowindow.open(map, pin) 
} 

$(document).ready(function() {
  initialize();
  $('#search_form').on('submit', function(event) {
    event.preventDefault();
    $.ajax({
      url: '/restaurants',
      method: 'get',
      data: $(this).serialize(),
      dataType: 'json'
    }).done( function(restaurants){
      for (var i in restaurants) {
        codeAddress(restaurants[i].restaurant.address + " Chicago", restaurants[i].restaurant);
      }
    });
  });


});

