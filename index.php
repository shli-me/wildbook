<?php

namespace wildbook;
include_once('header.php');

dbConnect();
checkLoggedIn();


$currentUser = $_SESSION['currentUser'];

?>



<?php

include_once('footer.php');