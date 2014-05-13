<?php
/**
 * Created by PhpStorm.
 * User: Shannon
 * Date: 5/13/14
 * Time: 1:56 PM
 */

namespace wildbook;

require_once('Classes/class_includes.php');
require_once('functions.php');

sessionStart();
checkLoggedIn();

if(isset($_POST['commentText']) && isset($_GET['p']))
{
    $params = array();
    $params[] = $_SESSION['currentUser']->getUsername();
    $params[] = $_GET['p'];
    $params[] = date('Y-m-d h:i:s');
    $params[] = $_POST['commentText'];
    runStoredProcedure('insert_comment', $params);
}


?>