<?php

/**
 * Redirects to new page
 * @param $url
 */
namespace wildbook;

function dbConnect()
{
    session_start();
    $dbConnection = new \mysqli('localhost', 'root', '', 'wildbook');
    if(mysqli_connect_errno()) {die(mysqli_connect_error());}
    return $dbConnection;
}

function redirectTo($url)
{
    header("Location:{$url}");
    exit;
}

function checkLoggedIn()
{
    // Show the login page if user isn't logged in
    if(!isset($_SESSION['currentUser']))
    {
        redirectTo('login.php');
    }
}

