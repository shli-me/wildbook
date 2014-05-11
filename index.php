<?php

namespace wildbook;

include_once('header.php');

dbConnect();
checkLoggedIn();


echo $_SESSION['currentUser'];
?>
hi index page