<?php

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
        header("Location:login.php");
    }
}

