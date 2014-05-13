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
                /*
                $this->likes        = $row['likes'];
                $this->activity 	= $row['actid']; // Will be turned into object? */
                $this->long      	= $row['longitude'];
                $this->lat 	        = $row['latitude'];
                $this->name         = $row['name'];
            }
            else
            {
                echo "Location not found";
            }
        }

        public function lat()
        {
            return $this->lat;
        }

        public function long()
        {
            return $this->long;
        }

        public function name()
        {
            return $this->name;
        }

        public function locid()
        {
            return $this->locid;
        }

        public function display()
        {
            ?>
                <div>
                    <?php echo $this->name() . " <div> <a href = 'locationtest.php?long=$this->long&lat=$this->lat'>" . $this->long() . " " . $this-> lat()."</a></div>"?>
                </div>

            <?php
        }
    }
}