<?php
/**
 * Created by PhpStorm.
 * User: Shannon
 * Date: 5/11/14
 * Time: 11:15 PM
 */
namespace wildbook;
include_once('header.php');

if(isset($_GET['search']))
{
    $users = array();
    $locations = array();
    $result = runStoredProcedure('populate_search1',$_GET['search']);

    while($row = $result->fetch_array())
    {
        $users[] = new User($row['username']);
    }

    $result2 = runStoredProcedure('populate_search2',$_GET['search']);

    while($row = $result2->fetch_array())
    {
        $locations[] = new location($row['locid']);
    }

}

?>
    <div class="container">



        <div class="row">

            <div class="col-sm-8 blog-main">
                <?php
                foreach($users as $use)
                {
                    $use->display();
                }
                foreach($locations as $locs)
                {
                    $locs->display();
                }
                ?>

            </div><!-- /.blog-main -->


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