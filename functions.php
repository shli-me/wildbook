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
 * @internal param $args
 *
 * @return \mysqli_result
 */
function runStoredProcedure($procedure, $params)
{
    $mysqli = dbConnect();
    $query = "CALL {$procedure}('";

    if(is_array($params))
    {
        foreach($params as $p)
        {
            $query .= $p . ',';
        }
        // Remove the extra comma at the end
        $query = substr($query, 0, strlen($query)-1);
    }
    else $query .= $params; // $params must be a string
    $query .= "');";
    echo $query;
    if(!$res = $mysqli->query($query)) echo "CALL failed: (" . $mysqli->errno . ") ". $mysqli->error;
    return $res->fetch_assoc();
}

function redirectTo($url)
{
    header("Location:{$url}");
    exit;
}

function checkLoggedIn()
{
    session_start();
    // Show the login page if user isn't logged in
    if(!isset($_SESSION['currentUser']))
    {
        $_SESSION['errMsg'] = "Redirected";
        redirectTo('login.php');
    }
}

