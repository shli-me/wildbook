CREATE DATABASE  IF NOT EXISTS `wildbook` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `wildbook`;
-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: 127.0.0.1    Database: wildbook
-- ------------------------------------------------------
-- Server version	5.6.17

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `activities`
--

DROP TABLE IF EXISTS `activities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activities` (
  `actid` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`actid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activities`
--

LOCK TABLES `activities` WRITE;
/*!40000 ALTER TABLE `activities` DISABLE KEYS */;
/*!40000 ALTER TABLE `activities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `cid` int(10) NOT NULL AUTO_INCREMENT,
  `author` varchar(100) NOT NULL,
  `postid` int(10) NOT NULL,
  `posttime` datetime NOT NULL,
  `text` text NOT NULL,
  PRIMARY KEY (`cid`),
  KEY `author` (`author`),
  KEY `postid` (`postid`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`author`) REFERENCES `users` (`username`),
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`postid`) REFERENCES `posts` (`postid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friends`
--

DROP TABLE IF EXISTS `friends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `friends` (
  `sentby` varchar(100) NOT NULL,
  `receivedby` varchar(100) NOT NULL,
  `status` varchar(10) NOT NULL,
  `permission_type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`sentby`,`receivedby`),
  KEY `receivedby` (`receivedby`),
  CONSTRAINT `friends_ibfk_1` FOREIGN KEY (`sentby`) REFERENCES `users` (`username`),
  CONSTRAINT `friends_ibfk_2` FOREIGN KEY (`receivedby`) REFERENCES `users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friends`
--

LOCK TABLES `friends` WRITE;
/*!40000 ALTER TABLE `friends` DISABLE KEYS */;
INSERT INTO `friends` VALUES ('JerryPin','PhilPen','Accepted',''),('JerryPin','RachelHen','Accepted',''),('PhilPen','AbbyGail','Pending',''),('PhilPen','JohnSmith','Accepted',''),('RachelHen','AbbyGail','Accepted',''),('RachelHen','JohnSmith','Accepted','');
/*!40000 ALTER TABLE `friends` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes_comments`
--

DROP TABLE IF EXISTS `likes_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `likes_comments` (
  `username` varchar(100) NOT NULL,
  `cid` int(10) NOT NULL,
  PRIMARY KEY (`username`,`cid`),
  KEY `cid` (`cid`),
  CONSTRAINT `likes_comments_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`),
  CONSTRAINT `likes_comments_ibfk_2` FOREIGN KEY (`cid`) REFERENCES `comments` (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes_comments`
--

LOCK TABLES `likes_comments` WRITE;
/*!40000 ALTER TABLE `likes_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `likes_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes_locations_activities`
--

DROP TABLE IF EXISTS `likes_locations_activities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `likes_locations_activities` (
  `username` varchar(100) NOT NULL DEFAULT '',
  `actid` int(10) NOT NULL DEFAULT '0',
  `locid` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`username`,`actid`,`locid`),
  KEY `actid` (`actid`),
  KEY `locid` (`locid`),
  CONSTRAINT `likes_locations_activities_ibfk_1` FOREIGN KEY (`actid`) REFERENCES `activities` (`actid`),
  CONSTRAINT `likes_locations_activities_ibfk_2` FOREIGN KEY (`username`) REFERENCES `users` (`username`),
  CONSTRAINT `likes_locations_activities_ibfk_3` FOREIGN KEY (`locid`) REFERENCES `locations` (`locid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes_locations_activities`
--

LOCK TABLES `likes_locations_activities` WRITE;
/*!40000 ALTER TABLE `likes_locations_activities` DISABLE KEYS */;
/*!40000 ALTER TABLE `likes_locations_activities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes_posts`
--

DROP TABLE IF EXISTS `likes_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `likes_posts` (
  `username` varchar(100) NOT NULL DEFAULT '',
  `postid` int(10) NOT NULL,
  PRIMARY KEY (`username`,`postid`),
  KEY `postid` (`postid`),
  CONSTRAINT `likes_posts_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`),
  CONSTRAINT `likes_posts_ibfk_2` FOREIGN KEY (`postid`) REFERENCES `posts` (`postid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes_posts`
--

LOCK TABLES `likes_posts` WRITE;
/*!40000 ALTER TABLE `likes_posts` DISABLE KEYS */;
/*!40000 ALTER TABLE `likes_posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locations` (
  `locid` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `longitude` decimal(10,0) NOT NULL,
  `latitude` decimal(10,0) NOT NULL,
  PRIMARY KEY (`locid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` VALUES (1,'Coney Island',74,41);
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts` (
  `postid` int(10) NOT NULL AUTO_INCREMENT,
  `author` varchar(100) NOT NULL,
  `receiver` varchar(100) NOT NULL,
  `text` text,
  `content` blob,
  `posttime` datetime NOT NULL,
  `permission_type` varchar(20) NOT NULL,
  `locid` int(10) DEFAULT NULL,
  `actid` int(10) DEFAULT NULL,
  PRIMARY KEY (`postid`),
  KEY `author` (`author`),
  KEY `receiver` (`receiver`),
  CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`author`) REFERENCES `users` (`username`),
  CONSTRAINT `posts_ibfk_2` FOREIGN KEY (`receiver`) REFERENCES `users` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,'JerryPin','RachelHen','Hi! How\'s it going?','','2014-03-25 10:10:00','Friends',NULL,NULL),(2,'JerryPin','JerryPin','Today I went to the beach!','','2014-03-02 12:00:00','Public',1,NULL),(3,'PhilPen','JerryPin','Hope everything is well.','','2014-03-26 10:11:00','Friends of Friends',NULL,NULL),(4,'RachelHen','JerryPin','Everything\'s great!','','2014-05-11 12:00:00','Friends of Friends',NULL,NULL);
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `username` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `firstname` varchar(100) NOT NULL,
  `lastname` varchar(100) NOT NULL,
  `gender` tinyint(1) NOT NULL,
  `street` varchar(100) NOT NULL,
  `state` char(2) NOT NULL,
  `city` varchar(100) NOT NULL,
  `zipcode` int(5) NOT NULL,
  `birthdate` date NOT NULL,
  `password` char(32) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('AbbyGail','AbbyGail@mail.com','Abby','Gail',0,'49 Freedom Road','NY','Brooklyn',11214,'1994-10-10','5f4dcc3b5aa765d61d8327deb882cf99'),('JerryPin','JerryPin@mail.com','Jerry','Pin',1,'444 Pine Ave.','NY','Brooklyn',11217,'1996-08-08','5f4dcc3b5aa765d61d8327deb882cf99'),('JohnSmith','JohnSmith@mail.com','John','Smith',1,'111 Main St.','NY','Brooklyn',11201,'1987-05-04','5f4dcc3b5aa765d61d8327deb882cf99'),('PhilPen','PhilPen@mail.com','Phil','Pen',1,'112 Rainbow Ave.','NY','New York',10003,'1988-06-09','5f4dcc3b5aa765d61d8327deb882cf99'),('RachelHen','RachelHen@mail.com','Rachel','Hen',0,'414 West St.','NY','New York',10001,'1975-05-05','5f4dcc3b5aa765d61d8327deb882cf99');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'wildbook'
--
/*!50003 DROP PROCEDURE IF EXISTS `populate_post` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `populate_post`(IN id int(10))
proc_main:BEGIN
SELECT author, receiver, text, content, posttime, permission_type, locid, actid
FROM posts
WHERE postid = id;

END proc_main ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `populate_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `populate_user`(IN user VARCHAR(100))
BEGIN
SELECT email, firstname, lastname, gender, street, state, city, zipcode, birthdate
FROM users
WHERE username = user;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `populate_user_friends` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `populate_user_friends`(IN user VARCHAR(100))
proc_main:BEGIN

SELECT sentby FROM friends WHERE receivedby = user AND status = 'Accepted'
UNION
SELECT receivedby FROM friends WHERE sentby = user AND status = 'Accepted';

END proc_main ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-05-11 20:25:28
