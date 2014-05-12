<?php
/**
 * Created by PhpStorm.
 * User: Shannon
 * Date: 5/10/14
 * Time: 9:07 PM
 */

namespace wildbook;


class FormInput {
    private $type;
    private $attributes;
    private $label;
    private $name;


    /**
     * Pass in the type, then a string of attributes (name="", value="", etc...)
     * Usually, only text and password types would need the $name param (for the LABEL tag)
     *
     *
     * @param $type
     * @param $attrib
     * @param null $label
     * @param null $name
     * @internal param $attributes
     */
    function __construct($type, $attrib, $label = null, $name = null)
    {
        $this->type = $type;
        $this->attributes = $attrib;
        $this->label = $label;
        $this->name = $name;
    }

    function display()
    {
        $html = "<input type='{$this->type}' {$this->attributes} >";
        switch($this->type)
        {
            case "radio":
                $html .= $this->label;
                break;
            case "password":
            case "text":
                $html = "<label for='{$this->name}'> {$this->label} </label>" . $html;
                break;
            default:
                break;
        }

        return $html;
    }
} 