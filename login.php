<?php
/**
 * Created by PhpStorm.
 * User: Shannon
 * Date: 5/9/14
 * Time: 9:36 PM
 */
namespace wildbook;
include_once('header.php');

// Login logic
if(isset($_POST['username']) && isset($_POST['password']))
{
    $username = $_POST['username'];
    $password = md5($_POST['password']);
    $dbConnection = dbConnect();
    $query = 'SELECT 1 FROM users WHERE username = ? AND pw = ?';
    $stmt = $dbConnection->prepare($query);
//    echo $query . "; "; //. $stmt;
    $stmt->bind_param('ss', $username, $password);
    $stmt->execute();
    $stmt->bind_result($result);
    $stmt->fetch();
    if(!$result) echo "Wrong username/password";
    else
    {
        echo "Successful login";
        $_SESSION['currentUser'] = new User($username);
        redirectTo('index.php');
    }
}
// Log out logic
else if (isset($_GET['cmd']))
{
    session_unset();
    unset($_GET['cmd']);
    redirectTo('login.php');
}
else
{
    // Check if logged in
    if(isset($_SESSION['currentUser'] ))
    {
        redirectTo('index.php');
    }
    else
    {
        ?>
        <div class="container">
            <form class="form-signin" role="form" action="login.php" method="post">
                <div class="form-group">
                    <label for="username" class="col-sm-2 control-label">Username</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" name="username" placeholder="Username">
                    </div>
                </div>
                <div class="form-group">
                    <label for="password" class="col-sm-2 control-label">Password</label>
                    <div class="col-sm-10">
                        <input type="password" class="form-control" name="password" placeholder="Password">
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <button type="submit" class="btn btn-default">Sign in</button>
                    </div>
                </div>
            </form>
        </div>
        <?php
    }
}

include_once('footer.php');