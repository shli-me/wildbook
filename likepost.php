<?php
/**
 * Created by PhpStorm.
 * User: Shannon
 * Date: 5/13/14
 * Time: 11:50 AM
 */
namespace wildbook;
require_once('Classes/class_includes.php');
require_once('functions.php');
sessionStart();
checkLoggedIn();

if (isset($_GET['pid']))
{
    $params = array();
    $params[] = $_SESSION['currentUser']->getUsername();
    $params[] = $_GET['pid'];
    $out = '@success';
    $result = runStoredProcedure('insert_post_likes', $params, $out);


    $likers = array();

    // Get the likers
    $result = runStoredProcedure('populate_post_likes', $_GET['pid']);
    while($row = $result->fetch_array())
    {
        $likers[] = new User($row['username']);
    }
    $result->free();

    $likeOrUnlike = 'Like';
    if(in_array($_SESSION['currentUser'], $likers)) $likeOrUnlike = 'Unlike';

    $returnStr = $_GET['pid'] . '%' . count($likers) . '&nbsp' . $likeOrUnlike . '%';


    if($likers)
    {
        foreach($likers as $liker)
        {
            $returnStr .= "
            <li> " .$liker->getNameLink() . "
            </li>
            ";
        }
    }

    echo $returnStr;

}
