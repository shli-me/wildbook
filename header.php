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
                    <a class="navbar-brand" href="user.php?u=<?php $_SESSION['currentUser']->getUsername() ?>">Home</a>
                    <a class="navbar-brand" href="login.php?cmd=logout">Log out</a>

                <?php
                    }
                ?>
                </div>
                <div class="navbar-collapse collapse">
                    <form class="navbar-form navbar-left" role="search">
                        <div class="form-group">
                            <input type="text" class="form-control" placeholder="Search">
                        </div>
                        <button type="submit" class="btn btn-default">Submit</button>
                    </form>
                </div><!--/.navbar-collapse -->
            </div>
        </div>

        <div class="container">