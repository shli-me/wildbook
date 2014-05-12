<?php
/**
 * Created by PhpStorm.
 * User: Shannon
 * Date: 5/10/14
 * Time: 7:52 PM
 */
namespace wildbook;
include_once("header.php");

if( isset($_POST['email'])      &&
    isset($_POST['username' ])  &&
    isset($_POST['firstname'])  &&
    isset($_POST['lastname' ])  &&
    isset($_POST['gender'])     &&
    isset($_POST['street'])     &&
    isset($_POST['state'])      &&
    isset($_POST['city'])       &&
    isset($_POST['zipcode'])    &&
    isset($_POST['birthdate'])  &&
    isset($_POST['password'])   )
{
    $params = array();
    $params[] = $_POST['username' ];
    $params[] = $_POST['email'];
    $params[] = $_POST['firstname'];
    $params[] = $_POST['lastname' ];
    $params[] = $_POST['gender'];
    $params[] = $_POST['street'];
    $params[] = $_POST['state'];
    $params[] = $_POST['city'];
    $params[] = $_POST['zipcode'];
    $params[] = $_POST['birthdate'];
    $params[] = md5($_POST['password']);

    $res = runStoredProcedure('insert_user', $params, '@fail');
    if($res[1]->error) { echo $res[1]->error; }
    $fail = $res[1]->query("SELECT @fail AS fail");
    if($fail->fetch_object()->fail)
    {
        $_POST['err'] = "Username already taken.";
    }
    else
    {
        $_POST['success'] = "Successfully registered!";
    }
}
else if(
    !isset($_POST['email'])      &&
    !isset($_POST['username' ])  &&
    !isset($_POST['firstname'])  &&
    !isset($_POST['lastname' ])  &&
    !isset($_POST['gender'])     &&
    !isset($_POST['street'])     &&
    !isset($_POST['state'])      &&
    !isset($_POST['city'])       &&
    !isset($_POST['zipcode'])    &&
    !isset($_POST['birthdate'])  &&
    !isset($_POST['password'])  )
{

}
else // A field was left empty
{

    ?>

    <div class="alert alert-danger">
        <p>Error: You didn't fill out all the fields</p>
    <?php

        if(!isset($_POST['email'])      ) echo "<p> Missing  email     </p> ";
        if(!isset($_POST['username' ])  ) echo "<p> Missing   username </p>    ";
        if(!isset($_POST['firstname'])  ) echo "<p> Missing   firstname</p>     ";
        if(!isset($_POST['lastname' ])  ) echo "<p> Missing lastname   </p>    ";
        if(!isset($_POST['gender'])     ) echo "<p> Missing    gender  </p>  ";
        if(!isset($_POST['street'])     ) echo "<p> Missing   street   </p>  ";
        if(!isset($_POST['state'])      ) echo "<p> Missing    state   </p> ";
        if(!isset($_POST['city'])       ) echo "<p> Missing   city     </p>";
        if(!isset($_POST['zipcode'])    ) echo "<p> Missing     zipcode</p>   ";
        if(!isset($_POST['birthdate'])  ) echo "<p> Missing   birthdate</p>     ";
        if(!isset($_POST['password'])   ) echo "<p> Missing    password</p>    ";
    ?>
    </div>

    <?php

}


if (isset($_POST['err']))
{
    ?>
    <div class="alert alert-danger">
        <?= $_POST['err'] ?>
    </div>
<?php
}

if (isset($_POST['success']))
{
    ?>
    <div class="alert alert-success">
        <?= $_POST['success'] ?>
    </div>

<?php
}

?>

<form role="form" action="register.php" method="post">
    <div class="form-group">
        <label for="email">Email address</label>
        <input type="email" class="form-control" name="email" placeholder="Enter email">
    </div>
    <div class="form-group">
        <label for="username">Username</label>
        <input type="text" class="form-control" name="username" placeholder="Username">
    </div>
    <div class="form-group">
        <label for="firstname">First Name</label>
        <input type="text" class="form-control" name="firstname" placeholder="First Name">
    </div>
    <div class="form-group">
        <label for="lastname">Last Name</label>
        <input type="text" class="form-control" name="lastname" placeholder="Last Name">
    </div>
    <div class="form-group">
        <label for="password">Password</label>
        <input type="password" class="form-control" name="password" placeholder="Password">
    </div>
    <div class="form-group">
        <label for="birthdate">Birthday</label>
        <input type="date" class="form-control" name="birthdate" placeholder="Password">
    </div>
    <div class="form-group">
        <label for="street">Address</label>
        <input type="text" class="form-control" name="street" placeholder="Address">
    </div>
    <div class="form-group">
        <label for="state">State</label>
        <select class="form-control" name="state">
            <option value="AL">Alabama</option>
            <option value="AK">Alaska</option>
            <option value="AZ">Arizona</option>
            <option value="AR">Arkansas</option>
            <option value="CA">California</option>
            <option value="CO">Colorado</option>
            <option value="CT">Connecticut</option>
            <option value="DE">Delaware</option>
            <option value="DC">District of Columbia</option>
            <option value="FL">Florida</option>
            <option value="GA">Georgia</option>
            <option value="HI">Hawaii</option>
            <option value="ID">Idaho</option>
            <option value="IL">Illinois</option>
            <option value="IN">Indiana</option>
            <option value="IA">Iowa</option>
            <option value="KS">Kansas</option>
            <option value="KY">Kentucky</option>
            <option value="LA">Louisiana</option>
            <option value="ME">Maine</option>
            <option value="MD">Maryland</option>
            <option value="MA">Massachusetts</option>
            <option value="MI">Michigan</option>
            <option value="MN">Minnesota</option>
            <option value="MS">Mississippi</option>
            <option value="MO">Missouri</option>
            <option value="MT">Montana</option>
            <option value="NE">Nebraska</option>
            <option value="NV">Nevada</option>
            <option value="NH">New Hampshire</option>
            <option value="NJ">New Jersey</option>
            <option value="NM">New Mexico</option>
            <option value="NY">New York</option>
            <option value="NC">North Carolina</option>
            <option value="ND">North Dakota</option>
            <option value="OH">Ohio</option>
            <option value="OK">Oklahoma</option>
            <option value="OR">Oregon</option>
            <option value="PA">Pennsylvania</option>
            <option value="RI">Rhode Island</option>
            <option value="SC">South Carolina</option>
            <option value="SD">South Dakota</option>
            <option value="TN">Tennessee</option>
            <option value="TX">Texas</option>
            <option value="UT">Utah</option>
            <option value="VT">Vermont</option>
            <option value="VA">Virginia</option>
            <option value="WA">Washington</option>
            <option value="WV">West Virginia</option>
            <option value="WI">Wisconsin</option>
            <option value="WY">Wyoming</option>
        </select>
    </div>
    <div class="form-group">
        <label for="city">City</label>
        <input type="text" class="form-control" name="city" placeholder="City">
    </div>
    <div class="form-group">
        <label for="zipcode">Zipcode</label>
        <input type="text" class="form-control" name="zipcode" placeholder="Zipcode">
    </div>
    <div class="radio">
        <label>
            <input type="radio" name="gender" value="0" checked>
            Female
        </label>
    </div>
    <div class="radio">
        <label>
            <input type="radio" name="gender" value="1">
            Male
        </label>
    </div>
    <button type="submit" class="btn btn-default">Submit</button>
</form>

<?php
include_once('footer.php');
?>
