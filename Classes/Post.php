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

        function __construct($postid)
        {
            $result = runStoredProcedure('populate_post', $postid);
            // Check for rows
            $row = $result->fetch_assoc();
            if(count($row))
            {
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
            $html = '<div class="post">';
            $html = '<div></div>';

            $html .= '</div>';
            return $html;
?>

            <div class="blog-post">
                <h2 class="blog-post-title"><?=$this->getPostTitle()?></h2>
                <p class="blog-post-meta"><?=$this->posttime?></p>
                <p>
                    <?php
                        if($this->imagesrc)
                        {
                            ?>
                            <img src="<?=$this->imagesrc?>" />
                            <?php
                        }

                    ?>
                </p>
                <p>
                    <?=$this->text?>
                </p>
            </div><!-- /.blog-post -->

<?php

        }

    }
}