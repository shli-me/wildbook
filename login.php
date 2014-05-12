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
    $query = 'SELECT 1 FROM users WHERE username = ? AND password = ?';
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
        session_start();
        $_SESSION['currentUser'] = new User($username);
        redirectTo('index.php');
    }
}
else {

    // Check if logged in
    if(isset($_SESSION['currentUser'] ))
    {
        redirectTo('index.php');
    }
    else
    {
        ?>
            <a href="register.php" >Sign up</a>
        <?php
        $form = new Form("login.php", "post", "Log in");
        $form->addInputs(new FormInput("text", "name='username'", "Username: ", "username"));
        $form->addInputs(new FormInput("password", "name='password'", "Password: ", "password"));
        echo $form->display();
    }
}