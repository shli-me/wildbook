<?php
/**
 * Created by PhpStorm.
 * User: Shannon
 * Date: 5/10/14
 * Time: 2:08 PM
 */

namespace wildbook {

    class Post {
        private $id;

        private $author;
        private $receiver;
        private $activity;
        private $location;
        private $imagesrc;
        private $text;
        private $posttime;
        private $permission;

        // An array of comments
        private $comments = array();
        private $likers = array();

        /**
         * Populates fields for post
         * $params can be either the postid or
         * an assoc array with all fields
         * @param $params
         *
         */
        function __construct($params)
        {
            // $params is an assoc array (probably from get_user_wallposts)
            if(is_array($params))
            {
                $this->id           = $params['postid'];
                $this->author   	= new User($params['author']);
                $this->receiver 	= new User($params['receiver']);
                $this->activity 	= $params['actid']; // Will be turned into object
                $this->location 	= $params['locid']; // Will be turned into object
                $this->imagesrc 	= $params['content'];
                $this->text     	= $params['caption'];
                $this->posttime		= $params['posttime'];
                $this->permission	= $params['permission_type'];

            }
            else // $params is the postid
            {
                $result = runStoredProcedure('populate_post', $params);
                // Check for rows
                $row = $result->fetch_assoc();
                if(count($row))
                {
                    $this->id = $params;
                    $this->author   	= new User($row['author']);
                    $this->receiver 	= new User($row['receiver']);
                    $this->activity 	= $row['actid']; // Will be turned into object
                    $this->location 	= $row['locid']; // Will be turned into object
                    $this->imagesrc 	= $row['content'];
                    $this->text     	= $row['caption'];
                    $this->posttime		= $row['posttime'];
                    $this->permission	= $row['permission_type'];
                }
                else
                {
                    echo "Post doesn't exist";
                }
                $result->free();
            }

            // Get the likers
            $result = runStoredProcedure('populate_post_likes', $this->id);
            while($row = $result->fetch_array())
            {
                $this->likers[] = new User($row['username']);
            }
            $result->free();

            // Get the comments
            $result = runStoredProcedure('populate_post_comments', $this->id);
            while($row = $result->fetch_array())
            {
                $this->comments[] = new Comment($row['cid']);
            }
            $result->free();

        }

        function getPostTitle()
        {
            $html = $this->author->getNameLink();
            if($this->author != $this->receiver)
            {
                $html .= displayArrow();
                $html .= $this->receiver->getNameLink();
            }
            return $html;
        }

        function display()
        {
?>

            <div class="panel panel-default">
                <h2 class="panel-heading"><?=$this->getPostTitle()?></h2>
                <div class="panel-body">
                    <p><?=$this->posttime?></p>
                        <?php
                    if($this->imagesrc)
                    {
                        ?>
                        <p>
                            <img src="<?=$this->imagesrc?>" />
                        </p>
                    <?php
                    }
                    ?>
                    <p>
                        <?=$this->text?>
                    </p>
                    <p>
                        <div class="btn-group">
                            <button id="post_<?=$this->id?>_likebtn" type="button" class="btn btn-default" onclick="likeAPost(<?=$this->id?>);">
                                <?php
                                if(in_array($_SESSION['currentUser'], $this->likers))
                                {
                                    echo count($this->likers) . " Unlike";
                                } else echo count($this->likers) .  " Like";
                                ?>
                            </button>
                            <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                                <span class="caret"></span>
                                <span class="sr-only">Toggle Dropdown</span>
                            </button>
                            <ul id="post_<?=$this->id?>_likes" class="dropdown-menu" role="menu">

                                <?php
                                if($this->likers)
                                {
                                    foreach($this->likers as $liker)
                                    {
                                    ?>
                                    <li>
                                        <?=$liker->getNameLink()?>
                                    </li>
                                <?php
                                    }
                                }
                                ?>
                            </ul>
                        </div>
                    </p>
                    <?php
                        if($this->comments)
                    ?>
                        <div class="panel-group" id="accordion">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                        <a data-toggle="collapse" data-parent="#accordion" href="#collapse<?=$this->id?>">
                                            <h4 class="panel-title">
                                                Comment (<?=count($this->comments)?>)
                                            </h4>
                                        </a>
                                </div>
                                <div id="collapse<?=$this->id?>" class="panel-collapse collapse">
                                    <div class="panel-body" id="commentTextBox">
                                        <form role="form" id="post_<?=$this->id?>_commentform" method="post" action="comment.php?p=<?=$this->id?>" >
                                            <input type="text" name="commentText" />
                                            <input type="Submit" id="post_<?=$this->id?>_submit" value="Submit" />
                                        </form>
                                    </div>
                                    <div class="panel-body" id="post_<?=$this->id?>_commentsList">
                                    <?php
                                        foreach($this->comments as $comment)
                                        {
                                            $comment->display();
                                        }
                                    ?>
                                        <script type="text/javascript">

                                            $("#post_<?=$this->id?>_commentform").submit(
                                                function(e){
                                                    $.ajax({ // create an AJAX call...
                                                        data: $(this).serialize(), // get the form data
                                                        type: $(this).attr('method'), // GET or POST
                                                        url: $(this).attr('action'), // the file to call
                                                        success: function(response) { // on success..
                                                            $('#post_<?=$this->id?>_commentsList').html(response); // update the DIV
                                                        }
                                                    });
                                                    return false;
                                                });


                                        </script>
                                    </div>

                                </div>
                            </div>
                        </div>
                    <?php
                    ?>
                </div>
            </div><!-- /.panel -->

<?php

        }

    }
}