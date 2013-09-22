google.maps.event.addDomListener(window, 'load', initialize);

var geocoder;
var map;

function initialize() {
  geocoder = new google.maps.Geocoder();
  var latlng = new google.maps.LatLng(41.9483, -87.6556);
  var mapOptions = {
    zoom: 14,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }
  map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
  infowindow = new google.maps.InfoWindow({ maxWidth: 320 }); 
}

function codeAddress() {
  var address = document.getElementById('zip').value;
  geocoder.geocode( { 'address': address}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      map.setCenter(results[0].geometry.location);
      
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
  infowindow.open(map) 
} 

$(document).ready(function() {

  $('#srch_map').on('submit', function(event) {
    event.preventDefault();
    codeAddress();
  });

});

