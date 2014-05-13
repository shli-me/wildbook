<?php
/**
 * Created by PhpStorm.
 * User: Shannon
 * Date: 5/11/14
 * Time: 11:15 PM
 */
namespace wildbook;
include_once('header.php');



if(isset($_GET['u']))
{
    $user = new User($_GET['u']);

    if(isset($_POST['wallposttext']))
    {
    /*
     * 	IN author VARCHAR(100),
        IN receiver VARCHAR(100),
        IN caption TEXT,
        IN content TEXT,
        IN posttime DATETIME,
        IN permission_type VARCHAR(20),
        IN locid INT(10),
        IN actid INT(10),
        OUT postid INT(10),
     */
        $params = array();
        $params[] = $_SESSION['currentUser']->getUsername();
        $params[] = $user->getUsername();
        $params[] = $_POST['wallposttext'];
        $params[] = null; // TODO
        $params[] = date('Y-m-d h:i:s');
        $params[] = 'Friends'; // TODO
        $params[] = null; // TODO
        $params[] = null; // TODO
        $out = '@pid';
        runStoredProcedure('insert_post', $params, $out);

    }
    $posts = array();

    $params = array();
    $params[] = $user->getUsername();
    $params[] = $_SESSION['currentUser']->getUsername();
    $result = runStoredProcedure('get_user_wallposts',$params);

    while($row = $result->fetch_array())
    {
        $posts[] = new Post($row);
    }

}
?>
<div class="container">

    <div class="blog-header">
        <h1 class="blog-title"><?=$user->getName()?></h1>
    </div>

    <div class="row">

        <div class="col-sm-8 blog-main">
            <form role="form" action="user.php?u=<?=$user->getUsername()?>" method="post">
                <div class="form-group">
                    <label for="wallposttext">Post something on <?=$user->getName()?>'s Wall</label>
                    <input type="text" class="form-control" name="wallposttext" placeholder="Enter message...">
                </div>
                <button type="submit" class="btn btn-default">Submit</button>
            </form>
            <?php
            foreach($posts as $post)
            {
                $post->display();
            }
            ?>

        </div><!-- /.blog-main -->

        <div class="col-sm-3 col-sm-offset-1 blog-sidebar">
            <div class="sidebar-module sidebar-module-inset">
                <h4>About</h4>
                <p>Username: <?=$user->getUsername()?> </p>
                <p>Birthday: <?=$user->getBirthdate()?> </p>
                <p>Gender: <?=$user->getGender()?> </p>
            </div>
            <div class="sidebar-module">
                <h4>Friends</h4>
                <?php
                    foreach($user->getFriends() as $friend)
                    {
                        $friend = new User($friend);
                        ?>
                        <p><?=$friend->getNameLink()?></p>
                        <?php
                        unset($friend);
                    }
                ?>
            </div>
        </div><!-- /.blog-sidebar -->

    </div><!-- /.row -->

</div><!-- /.container -->

    <div class="blog-footer">
        <p>Blog template built for <a href="http://getbootstrap.com">Bootstrap</a> by <a href="https://twitter.com/mdo">@mdo</a>.</p>
        <p>
            <a href="#">Back to top</a>
        </p>
    </div>
<?php

include_once('footer.php');
?>