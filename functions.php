<?php

/**
 * Redirects to new page
 * @param $url
 */
namespace wildbook;


function dbConnect()
{
    $dbConnection = new \mysqli('localhost', 'root', '', 'wildbook');
    if(mysqli_connect_errno()) {die(mysqli_connect_error());}
    return $dbConnection;
}


/**
 * Runs a stored procedure with the arguments passed in
 *
 * @param $procedure
 * @param $params
 * @param $out
 * @internal param $args
 *
 * @return \mysqli_result
 */
function runStoredProcedure($procedure, $params, $out=null)
{
    $mysqli = dbConnect();
    $query = "CALL {$procedure}(";

    if(is_array($params)) // $params is an array
    {
        echo "params is an array";
        foreach($params as $p)
        {
            $query .= "'" . $p . "',";
        }
        // Remove the extra comma at the end if necessary
        if(!$out) $query = substr($query, 0, strlen($query)-1);
    }
    else // $params must be a string
    {
        $query .= "'" . $params . "'";
        if($out) $query .= ',';
    }
    $query .= $out;
    $query .= ");";
    echo $query;
    if(!$res = $mysqli->query($query)) echo "CALL failed: (" . $mysqli->errno . ") ". $mysqli->error;

    // If this procedure has an OUT param, we want to return the connection as well
    if($out)
    {
        $res[] = $mysqli;
    }
    else return $res;
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
        $_SESSION['errMsg'] = "Redirected";
        redirectTo('login.php');
    }
}

function sessionStart()
{
    if(!isset($_SESSION)) session_start();
}