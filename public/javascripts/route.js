$(document).ready(function() {
    navigatorGeolocation()
});

  function map_render(lat, long){
    var directionsService = new google.maps.DirectionsService();
    directionsDisplay = new google.maps.DirectionsRenderer();
    var gmapOptions = {
      zoom: 2,
      center: new google.maps.LatLng(lat, long),
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
  // initialize the map with your options
    gmap = new google.maps.Map(document.getElementById("map_canvas"),gmapOptions);
    directionsDisplay.setMap(gmap);
    //ROUTING
    var request = {
        origin: new google.maps.LatLng(lat, long),
        destination: destination,
        travelMode: google.maps.DirectionsTravelMode.DRIVING
    };
        directionsService.route(request, function(response, status) {
      if (status == google.maps.DirectionsStatus.OK) {
        directionsDisplay.setDirections(response);
      }
    // cant establish ROUTING
    else
      alert('The route can not be established')
      markerOptions = {
        map: gmap,
        position: new google.maps.LatLng(flat, flong),
        icon: 'http://google-maps-icons.googlecode.com/files/vegetarian.png'
      };
      marker = new google.maps.Marker(markerOptions);
      attachMessage(marker, 'Requested Farm')
      userOptions = {
        map: gmap,
        position: new google.maps.LatLng(lat, long)
      }
      user = new google.maps.Marker(userOptions)
      attachMessage(user, 'Here you are!')
    });
  }

function navigatorGeolocation(){
    if (navigator.geolocation)
    {
        navigator.geolocation.getCurrentPosition(function (position) {
            map_render(position.coords.latitude, position.coords.longitude)
            },function (error)
            {
            switch(error.code)
                {
                    case error.TIMEOUT:
                        alert ('Timeout');
                        break;
                    case error.POSITION_UNAVAILABLE:
                        alert ('Position unavailable');
                        break;
                    case error.PERMISSION_DENIED:
                        map_render(lat, long)
                        break;
                    case error.UNKNOWN_ERROR:
                        alert ('Unknown error');
                        break;
                }
            }
            );
}}