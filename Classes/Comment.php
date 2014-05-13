<?php
/**
 * Created by PhpStorm.
 * User: Shannon
 * Date: 5/10/14
 * Time: 5:00 PM
 */

namespace wildbook;


class Comment {
    private $id;

    private $author;
    private $postid;
    private $posttime;

    private $text;

    function __construct($id)
    {
        $this->id = $id;
        $result = runStoredProcedure('populate_comment', $id);
        $row = $result->fetch_assoc();
        $this->author   = $row['author'];
        $this->postid = $row['postid'];
        $this->posttime = $row['posttime'];
        $this->text = $row['text'];
    }

} 