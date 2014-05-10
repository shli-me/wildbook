<?php
/**
 * Created by PhpStorm.
 * User: Shannon
 * Date: 5/10/14
 * Time: 3:19 PM
 */

namespace wildbook {

    class User {
        private $username;
        private $firstName;
        private $lastName;
        private $profilePictureDir;

        private $birhtdate;
        private $address;
        private $state;
        private $city;
        private $zip;

        private $friends = array();

        /**
         * @param User $other
         * @return array of mutual friends
         */
        public function getMutualFriends(User $other)
        {
            return array_intersect($other->friends, $this->friends);
        }

        public function getUsername() { return $this->username; }
        public function getName() { return $this->firstName . " " . $this->lastName; }
        public function getFirstName() { return $this->firstName; }
        public function getLastName() { return $this->lastName; }
        /**
         * @return mixed
         */
        public function getAddress()
        {
            return $this->address;
        }

        /**
         * @return mixed
         */
        public function getBirhtdate()
        {
            return $this->birhtdate;
        }

        /**
         * @return mixed
         */
        public function getCity()
        {
            return $this->city;
        }

        /**
         * @return array
         */
        public function getFriends()
        {
            return $this->friends;
        }

        /**
         * @return mixed
         */
        public function getProfilePictureDir()
        {
            return $this->profilePictureDir;
        }

        /**
         * @return mixed
         */
        public function getState()
        {
            return $this->state;
        }

        /**
         * @return mixed
         */
        public function getZip()
        {
            return $this->zip;
        }


    }
}