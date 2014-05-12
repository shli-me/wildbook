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
        private $image;
        private $text;

        // An array of comments
        private $comments = array();
        private $likers = array();

        function __construct($postid)
        {

        }

        function display()
        {
            $html = '<div class="post">';
            $html = '<div></div>';

            $html .= '</div>';
            return $html;
        }

    }
}