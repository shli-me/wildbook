<?php

namespace wildbook;
include_once('header.php');

dbConnect();
checkLoggedIn();


$user = $_SESSION['currentUser'];
$posts = array();
$result = runStoredProcedure('get_news_feed',$user->getUsername());

while($row = $result->fetch_array())
{
    $posts[] = new Post($row);
}

?>
    <div class="container">

        <div class="blog-header">
            <h1 class="blog-title"></h1>
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