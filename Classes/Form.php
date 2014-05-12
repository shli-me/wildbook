<?php
/**
 * Created by PhpStorm.
 * User: Shannon
 * Date: 5/10/14
 * Time: 4:24 PM
 */

namespace wildbook {
    require_once('class_includes.php');

    class Form {
        private $action;
        private $method;
        private $inputs = array();
        private $submit;

        /**
         * Create a form with an action page, method (POST or GET),
         * and the text for the submit button (if any).
         *
         * @param $act
         * @param $meth
         * @param null $sub
         *
         */
        function __construct($act, $meth, $sub = null)
        {
            $this->action = $act;
            $this->method = $meth;

            if($sub)
            {
                $this->submit = new FormInput("submit", $sub);
            }
            else
            {
                $this->submit = null;
            }

        }

        function addInputs($formInput)
        {
            $this->inputs[] = $formInput;
        }

        function display()
        {
            $html = '<form action="'. $this->action .'" method="'. $this->method . '" class="'.$this->class.'" role=>';
            foreach($this->inputs as $in)
            {
                $html .= $in->display() . '</br>';
            }
            if($this->submit) $html .= $this->submit->display();
            $html .= '</form>';
            return $html;
        }
    }
}