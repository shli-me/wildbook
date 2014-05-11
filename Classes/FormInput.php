<?php
/**
 * Created by PhpStorm.
 * User: Shannon
 * Date: 5/10/14
 * Time: 9:07 PM
 */

namespace wildbook;


class FormInput {
    private $display;
    private $name;
    private $type;

    /**
     * Create HTML for form input
     * if $disp is set, that means the $name is also given
     * @param $type
     * @param null $name
     * @param null $disp
     *
     */
    function __construct($type, $name=null, $disp=null)
    {
        $this->type = $type;
        $this->name = $name;
        $this->display = $disp;
    }

    function display()
    {
        $html = ($this->display ? '<label for="' .$this->name .'">' . $this->display . '</label>' : '')
                .
                '<input type="'.$this->type.'" ';
                if($this->type=="submit" && $this->name)
                    $html .= 'value="'.$this->name . '"';
                else if ($this->name)
                {
                    $html .= 'name="'.$this->name .'"';
                }
        $html .= '/>';
        return $html;
    }
} 