$(document).ready(function() {
    navigatorGeolocation();
});

function map_render(distance, geolat, geolong){

        var gmapOptions = {
          zoom: 12,
          mapTypeId: google.maps.MapTypeId.ROADMAP
        };
      // initialize the map with your options
        gmap = new google.maps.Map(document.getElementById("map_canvas"),gmapOptions);
      var latlngbounds = new google.maps.LatLngBounds();
      for (i in distance.slice(0,8)) {
        position = new google.maps.LatLng(distance[i][0].split(',')[0], distance[i][0].split(',')[1] )
        latlngbounds.extend(position)
        markerOptions = {
          map: gmap,
          position: position,
          icon: 'http://google-maps-icons.googlecode.com/files/vegetarian.png'
        }
        marker = new google.maps.Marker(markerOptions);
        attachMessage(marker, distance[i][0].split(',')[2])
        }
       console.log(geolat, geolong)
      user_position = new google.maps.LatLng(geolat, geolong)
      latlngbounds.extend(user_position)
        markerOptions = {
          map: gmap,
          position: user_position,
          icon: 'http://www.google.com/mapfiles/arrow.png'
        }
        marker = new google.maps.Marker(markerOptions);
        attachMessage(marker, 'Here you are')

      gmap.fitBounds( latlngbounds );
  }

function navigatorGeolocation(){
    if (navigator.geolocation)
    {
        navigator.geolocation.getCurrentPosition(function (position) {
            map_render(distance, position.coords.latitude, position.coords.longitude)
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
                        map_render(distance, user_coords[0], user_coords[1])
                        break;
                    case error.UNKNOWN_ERROR:
                        alert ('Unknown error');
                        break;
                }
            }
            );
}}
