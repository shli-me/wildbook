<?php
namespace wildbook;
require_once('Classes/class_includes.php');
require_once('functions.php');

sessionStart();

?>
<!DOCTYPE HTML>
<html>
    <head>
        <link rel="stylesheet" href="css/bootstrap.css" />
        <link rel="stylesheet" href="css/bootstrap-theme.css" />
        <link rel="stylesheet" href="css/mystyle.css" />
        <script type="text/javascript">

            // Get the HTTP Object
            function getHTTPObject(){
                if (window.ActiveXObject) return new ActiveXObject("Microsoft.XMLHTTP");
                else if (window.XMLHttpRequest) return new XMLHttpRequest();
                else {
                    alert("Your browser does not support AJAX.");
                    return null;
                }
            }

            // Change the value of the outputText field
            function setOutput(){
                if(httpObject.readyState == 4){
                    var likeStrings = httpObject.responseText.split("%");
                    /*
                     0 - postid
                     1 - Like or Unlike button
                     2 - list of people who like it
                     */
                    document.getElementById("post_" + likeStrings[0] +"_likebtn").innerHTML = likeStrings[1];
                    document.getElementById("post_" + likeStrings[0] +"_likes").innerHTML = likeStrings[2];
                }

            }

            // Implement business logic
            function likeAPost(postid){
                httpObject = getHTTPObject();
                if (httpObject != null) {
                    httpObject.open("GET", "likepost.php?pid="
                        +postid);
                    httpObject.send(null);
                    httpObject.onreadystatechange = setOutput;
                }
            }

            var httpObject = null;

        </script>
    </head>
    <body>


        <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
            <div class="container">
                <div class="navbar-header">
                    <a class="navbar-brand" href="index.php">Wildbook</a>
                <?php
                // Display sign in/register if not logged in
                    if(!isset($_SESSION['currentUser']))
                    {
                ?>
                    <a class="navbar-brand" href="login.php">Sign in</a>
                    <a class="navbar-brand" href="register.php">Register</a>
                <?php
                    }
                // Display link to user's homepage if logged in (and a log out button)
                    else
                    {
                ?>
                    <a class="navbar-brand" href="user.php?u=<?=$_SESSION['currentUser']->getUsername()?>"><?=$_SESSION['currentUser']->getUsername()?></a>
                    <a class="navbar-brand" href="login.php?cmd=logout">Log out</a>

                <?php
                    }
                ?>
                </div>
                <div class="navbar-collapse collapse">
                    <form class="navbar-form navbar-left" name = "search" action = "Search.php" method = "get">
                        <div class="form-group">
                            <input type="text" class="form-control" placeholder="Search" name = "search">
                        </div>
                        <input type="submit" class="btn btn-default">Submit</button>
                    </form>
                </div><!--/.navbar-collapse -->
            </div>
        </div>

        <div class="container">