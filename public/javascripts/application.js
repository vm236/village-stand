$(document).ready(function() {
//    navigator.geolocation.getCurrentPosition(function(pos){
//    SetCookie('latitude', pos.coords.latitude)
//    SetCookie('longitude', pos.coords.longitude)
//  });

    $('#farm').tabs();

    $('.add_to_cart_link')
            .bind("ajax:success", function(data, status, xhr) {
                marketplace_add_product()
             });
    $('.quantity-add-link')
            .bind("ajax:success", function(data, status, xhr){
                var quantity_html = $(this).parent().parent().find('.cart_item_quantity');
                var quantity = parseInt(quantity_html.html()) + 1;
                quantity_html.html(quantity);
                var price = parseInt(quantity_html.prev().html());
                quantity_html.next().html(price * quantity + '$');

                var money_total = $('#money_total');
                money_total.html((parseInt(money_total.html()) + price) + '$')
                money_total.effect("highlight", { color: 'red'}, 500);

    });

    $('.quantity-remove-link')
            .bind("ajax:success", function(data, status, xhr){
                var quantity_html = $(this).parent().parent().find('.cart_item_quantity');
                var quantity = parseInt(quantity_html.html());
                var price = parseInt(quantity_html.prev().html());

                var money_total = $('#money_total');
                money_total.effect("highlight", { color: '#006600'}, 1000);
                money_total.html((parseInt(money_total.html()) - price) + '$');

                if (quantity > 1){
                    quantity_html.html((quantity - 1));
                    quantity_html.next().html(price * (quantity - 1) + '$');
                }
                else {
                    $(this).parent().parent().fadeOut('slow')
                }
    });

});

function sortMultiDimensional(a,b) // for sorting farms on gmap
{
    // this sorts the array using the second element
    return ((a[1] < b[1]) ? -1 : ((a[1] > b[1]) ? 1 : 0));
}

// marketplace helper
function marketplace_add_product(){
    if ($('#notice').length)
    {
        $('#notice').effect("highlight", { color: '#006600'}, 4000);
    }
    else
    {
       $('#title-bar').prepend('<div id="notice" style="display:none">Product added to cart</div>')
       $('#notice').slideDown('slow')
    }

    $('#cart-image-link').attr('src','images/shopping_cart_add.png');
}

// google maps helper
function attachMessage(marker, message) {
      var infowindow = new google.maps.InfoWindow(
          { content: message });
      google.maps.event.addListener(marker, 'click', function() {
        infowindow.open(gmap,marker);
      });
}

function SetCookie(cookieName,cookieValue,nDays) {
 var today = new Date();
 var expire = new Date();
 if (nDays==null || nDays==0) nDays=1;
 expire.setTime(today.getTime() + 3600000*24*nDays);
 document.cookie = cookieName+"="+escape(cookieValue)
                 + ";expires="+expire.toGMTString();
}