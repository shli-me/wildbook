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
    $posts = array();

    $user = new User($_GET['u']);
    $result = runStoredProcedure('get_user_wallposts',$user->getUsername());

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