<?php
/**
 * Created by PhpStorm.
 * User: IGDB
 * Date: 5/12/14
 * Time: 5:31 PM
 */
namespace wildbook;


class LocationTest {
}
?>

<!DOCTYPE html>
<html>
<head>
    <style type="text/css">
        html { height: 100% }
        body { height: 100%; margin: 0; padding: 0 }
        #map-canvas { height: 100% }
    </style>
    <script type="text/javascript"
            src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB9ja2StsNKqePOjYY0EbInWW0Cvo4Ni8w&sensor=false">
    </script>
    <script type="text/javascript">
        function initialize() {
            var mapOptions = {
                <!-- USE THE LATITUDE AND LONGITUDE FROM THE DATABSE RIGHT HERE-->
                <!-- USE THE LATITUDE AND LONGITUDE FROM THE DATABSE RIGHT HERE-->
                <!-- USE THE LATITUDE AND LONGITUDE FROM THE DATABSE RIGHT HERE-->
                center: {lat: 40.7127, lng: -74.0059},<!-- USE THE LATITUDE AND LONGITUDE FROM THE DATABSE RIGHT HERE-->
                zoom: 12
            };
            var map = new google.maps.Map(document.getElementById("map-canvas"),
                mapOptions);
        }
    </script>
</head>
<body onload="initialize()">
<div id="map-canvas"/>
</body>
</html>