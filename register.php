<?php
/**
 * Created by PhpStorm.
 * User: Shannon
 * Date: 5/10/14
 * Time: 7:52 PM
 */
namespace wildbook;
include_once("header.php");


$form = new Form("register.php", "post", "Register");
$form->addInputs(new FormInput("text", "userName", "Username: "));
$form->addInputs(new FormInput("text", "email", "Email: "));
$form->addInputs(new FormInput("text", "firstName", "First Name: "));
$form->addInputs(new FormInput("text", "lastName", "Last Name: "));
$form->addInputs(new FormInput("text", "address", "Address: "));
$form->addInputs(new FormInput("text", "city", "City: "));
$form->addInputs(new FormInput("text", "state", "State: "));
$form->addInputs(new FormInput("text", "zip", "Zipcode: "));
echo $form->display();
?>
