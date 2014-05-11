<?php
/**
 * Created by PhpStorm.
 * User: Shannon
 * Date: 5/11/14
 * Time: 11:47 AM
 */

namespace wildbook;


foreach(glob("Classes/*.php") as $filename)
{
    include_once $filename;
}
//
//require_once("Classes/Comment.php");
//require_once("Classes/Form.php");
//require_once("Classes/FormInput.php");
//require_once("Classes/Post.php");
//require_once("Classes/User.php");

require_once('functions.php');