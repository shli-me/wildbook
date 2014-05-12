<?php

namespace wildbook;
include_once('header.php');

dbConnect();
checkLoggedIn();


$currentUser = $_SESSION['currentUser'];

/*
 * array of Post objects -
 *  Get all recent posts from friends of currentUser (order descending datetime) for last few days
 *
 */

?>



<?php

include_once('footer.php');