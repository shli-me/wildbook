-- DROP DATABASE wildbook;


CREATE DATABASE IF NOT EXISTS `wildbook` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `wildbook`;


CREATE TABLE IF NOT EXISTS `users` (
  `username` 	varchar(100) NOT NULL,
  `email`	 	varchar(100) NOT NULL,
  `firstname` 	varchar(100) NOT NULL,
  `lastname` 	varchar(100) NOT NULL,
  `gender` 		bool NOT NULL,
  `street` 		varchar(100) NOT NUlL,
  `state` 		char(2)  NOT NULL,
  `zipcode` 	int(5) NOT NULL,
  `birthdate` 	date NOT NULL,
  PRIMARY KEY (`username`)
) ;

CREATE TABLE IF NOT EXISTS `locations` (
  `locid` 	int(10) NOT NULL AUTO_INCREMENT,
  `name` 	varchar(100) NOT NULL,
  `longitude` 	DECIMAL NOT NULL,
  `latitude` 	DECIMAL NOT NUlL,
  PRIMARY KEY (`locid`)
) ;

CREATE TABLE IF NOT EXISTS `activities` (
  `actid` 	int(10) NOT NULL AUTO_INCREMENT,
  `name` 	varchar(100) NOT NULL,
  PRIMARY KEY (`actid`)
) ;

CREATE TABLE IF NOT EXISTS `likes_locations_activities` (
  `username` varchar(100),
  `actid` 	int(10),
  `locid` 	int(10),
  PRIMARY KEY (`username`, `actid`, `locid`),
  FOREIGN KEY (`actid`) REFERENCES activities (actid) ,
  FOREIGN KEY (`username`) REFERENCES users (username) ,
  FOREIGN KEY (`locid`) REFERENCES locations (locid) 
) ;

CREATE TABLE IF NOT EXISTS `posts` (
  `postid` 		int(10) NOT NULL AUTO_INCREMENT,
  `author` 		varchar(100) NOT NULL,
  `receiver` 	varchar(100) NOT NULL,
  `text` 		TEXT NULL,
  `content` 	BLOB NULL,
  `posttime` 	DATETIME NOT NULL,
  `permission_type` 	varchar(20) NOT NULL,
  `locid` 	int(10) NUlL,
  `actid` 	int(10) NUlL,
  PRIMARY KEY (`postid`),
  FOREIGN KEY (`author`) REFERENCES users (username) ,
  FOREIGN KEY (`receiver`) REFERENCES users (username)
) ;

CREATE TABLE IF NOT EXISTS `likes_posts` (
  `username` varchar(100),
  `postid` 	INT(10) NOT NULL,
  PRIMARY KEY (`username`, `postid`),
  FOREIGN KEY (`username`) REFERENCES users (username) ,
  FOREIGN KEY (`postid`) REFERENCES posts (postid) 
) ;


CREATE TABLE IF NOT EXISTS `comments` (
  `cid` 	INT(10) NOT NULL AUTO_INCREMENT,
  `author`  VARCHAR(100) NOT NULL,
  `postid`	INT(10) NOT NULL,
  `posttime` 	DATETIME NOT NULL,
  `text` 	TEXT NOT NULL,
  PRIMARY KEY (`cid`),
  FOREIGN KEY (`author`) REFERENCES users (username) ,
  FOREIGN KEY (`postid`) REFERENCES posts (postid) 
) ;

CREATE TABLE IF NOT EXISTS `likes_comments` (
  `username` varchar(100) NOT NULL,
  `cid` 	INT(10) NOT NULL,
  PRIMARY KEY (`username`, `cid`),
  FOREIGN KEY (`username`) REFERENCES users (username) ,
  FOREIGN KEY (`cid`) REFERENCES comments (cid) 
) ;

CREATE TABLE IF NOT EXISTS `friends` (
  `sentby` 		VARCHAR(100) NOT NULL,
  `receivedby` 	VARCHAR(100) NOT NULL,
  `status` 	VARCHAR(10) NOT NULL,
  `permission_type` varchar(20) NULL,
  PRIMARY KEY (`sentby`, `receivedby`),
  FOREIGN KEY (`sentby`) REFERENCES users (username) ,
  FOREIGN KEY (`receivedby`) REFERENCES users (username)
) ;

