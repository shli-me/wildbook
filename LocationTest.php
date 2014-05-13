
/**
 * Created by PhpStorm.
 * User: IGDB
 * Date: 5/12/14
 * Time: 5:31 PM
 */


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
                center: { <?php echo"lat: {$_GET['lat']} , lng: {$_GET['long']}" ?>},
                zoom: 12
            };
            var map = new google.maps.Map(document.getElementById("map-canvas"),
                mapOptions);

            var marker = new google.maps.Marker({
                position: { <?php echo"lat: {$_GET['lat']} , lng: {$_GET['long']}" ?>},
                map: map
            });
        }
    </script>
</head>
<body onload="initialize()">
<div id="map-canvas"/>
</body>
</html>