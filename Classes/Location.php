<?php
/**
 * Created by PhpStorm.
 * User: IGDB
 * Date: 5/12/14
 * Time: 5:30 PM
 */

namespace wildbook;
{
    class Location
    {
        private $likes;
        private $long;
        private $lat;
        private $name;

        function __construct($locid)
        {

            $result = runStoredProcedure('populate_loc', $locid);
            // Check for rows
            $row = $result->fetch_assoc();
            if(count($row))
            {
                $this->id = $locid;
                $this->likes        = $row['likes'];
                $this->activity 	= $row['actid']; // Will be turned into object?
                $this->long      	= $row['long'];
                $this->lat 	        = $row['lat'];
                $this->name         = $row['name'];
            }
            else
            {
                echo "Location not found";
            }
        }

        public function seemap()
        {

        }
    }
}

?>