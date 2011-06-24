$(document).ready(function() {
    $('.field_with_errors input').each(function(){
        $('<span>*</span>').insertBefore(this);
    });
    map_render()
});

    function map_render(){
      var user_location = $('#coords').val().split(' ')
      var gmapOptions = {
        zoom: 7,
        center: new google.maps.LatLng(user_location[0], user_location[1]),
        mapTypeId: google.maps.MapTypeId.ROADMAP
      };
    // initialize the map with your options
      gmap = new google.maps.Map(document.getElementById("register_map"),gmapOptions);

      var marker;

    function placeMarker(location) {
      if ( marker ) {
        marker.setPosition(location);
      } else {
        marker = new google.maps.Marker({
          position: location,
          map: gmap
        });
      }
    }
    google.maps.event.addListener(gmap, 'click', function(event) {
      placeMarker(event.latLng);
      document.getElementById("user_latitude").value = event.latLng.Ja
      document.getElementById("user_longitude").value = event.latLng.Ka
      console.log(event)
    });
}
