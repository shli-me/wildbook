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
  `caption` text,
  `content` text COMMENT 'Link/path to the content on the server',
  `posttime` datetime NOT NULL,
  `permission_type` varchar(20) NOT NULL,
  `locid` int(10) DEFAULT NULL,
  `actid` int(10) DEFAULT NULL,
  PRIMARY KEY (`postid`),
  KEY `author` (`author`),
  KEY `receiver` (`receiver`),
  CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`author`) REFERENCES `users` (`username`),
  CONSTRAINT `posts_ibfk_2` FOREIGN KEY (`receiver`) REFERENCES `users` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,'JerryPin','RachelHen','Hi! How\'s it going?','','2014-03-25 10:10:00','Friends',NULL,NULL),(2,'JerryPin','JerryPin','Today I went to the beach!','','2014-03-02 12:00:00','Public',1,NULL),(3,'PhilPen','JerryPin','Hope everything is well.','','2014-03-26 10:11:00','Friends of Friends',NULL,NULL),(4,'RachelHen','JerryPin','Everything\'s great!','','2014-05-11 12:00:00','Friends of Friends',NULL,NULL),(5,'jerrypin','jerrypin','Hi!','','2014-05-12 11:46:30','Public',0,0),(6,'jerrypin','jerrypin','Hi!',NULL,'2014-05-12 11:46:59','Public',NULL,NULL),(7,'philpen','philpen','Hey',NULL,'2014-05-13 11:42:48','Friends',NULL,NULL),(8,'philpen','philpen','This is my wall! ',NULL,'2014-05-13 11:42:56','Friends',NULL,NULL),(9,'philpen','JerryPin','Hey Jerry How are things going?',NULL,'2014-05-13 11:43:05','Friends',NULL,NULL),(10,'philpen','RachelHen','Hi friend, you have not responded to me yet',NULL,'2014-05-13 11:46:14','Friends',NULL,NULL),(11,'philpen','philpen','',NULL,'2014-05-13 12:58:28','Friends',NULL,NULL);
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
  `pw` char(32) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('AbbyGail','AbbyGail@mail.com','Abby','Gail',0,'49 Freedom Road','NY','Brooklyn',11214,'1994-10-10','5f4dcc3b5aa765d61d8327deb882cf99'),('annon','annon@an','shannon','shannon',0,'Shannon','AL','Shannon',11232,'1994-11-11','d41d8cd98f00b204e9800998ecf8427e'),('James','James@an','shannon','shannon',0,'Shannon','AL','Shannon',11232,'1994-11-11','d41d8cd98f00b204e9800998ecf8427e'),('JerryK','jamie@jamies','John','John',1,'john','AL','john',11232,'1994-11-11','d41d8cd98f00b204e9800998ecf8427e'),('JerryPin','JerryPin@mail.com','Jerry','Pin',1,'444 Pine Ave.','NY','Brooklyn',11217,'1996-08-08','5f4dcc3b5aa765d61d8327deb882cf99'),('john','john@jon','john','john',1,'john','AL','john',11232,'1994-11-11','527bd5b5d689e2c32ae974c6229ff785'),('Johnny','john@jo','John','John',1,'john','AL','john',11232,'1994-11-11','527bd5b5d689e2c32ae974c6229ff785'),('JohnSmith','JohnSmith@mail.com','John','Smith',1,'111 Main St.','NY','Brooklyn',11201,'1987-05-04','5f4dcc3b5aa765d61d8327deb882cf99'),('PhilPen','PhilPen@mail.com','Phil','Pen',1,'112 Rainbow Ave.','NY','New York',10003,'1988-06-09','5f4dcc3b5aa765d61d8327deb882cf99'),('RachelHen','RachelHen@mail.com','Rachel','Hen',0,'414 West St.','NY','New York',10001,'1975-05-05','5f4dcc3b5aa765d61d8327deb882cf99'),('shannon','shannon@shan','shannon','shannon',0,'Shannon','AL','Shannon',11232,'1994-11-11','5f4dcc3b5aa765d61d8327deb882cf99');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'wildbook'
--
/*!50003 DROP FUNCTION IF EXISTS `are_fofs` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `are_fofs`(user1 VARCHAR(100), user2 VARCHAR(100)) RETURNS int(11)
BEGIN

SELECT COUNT(*) INTO @fofs FROM friends
WHERE user2 IN (
	SELECT sentby FROM friends WHERE receivedby IN (

		SELECT sentby FROM friends WHERE receivedby = user1 AND status = 'Accepted'
		UNION
		SELECT receivedby FROM friends WHERE sentby = user1 AND status = 'Accepted' 

	) AND status = 'Accepted' AND receivedby <> user1
	UNION
	SELECT receivedby FROM friends WHERE sentby IN (

		SELECT sentby FROM friends WHERE receivedby = user1 AND status = 'Accepted'
		UNION
		SELECT receivedby FROM friends WHERE sentby = user1 AND status = 'Accepted' 

	) AND status = 'Accepted' AND sentby <> user1
);

RETURN @fofs;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `are_friends` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `are_friends`(user1 VARCHAR(100), user2 VARCHAR(100)) RETURNS tinyint(1)
BEGIN

SELECT COUNT(*) INTO @returnVal FROM friends WHERE 
( (sentby = user1 AND receivedby = user2) OR (sentby = user2 AND receivedby = user1) )
AND status = 'Accepted';


RETURN @returnVal;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `user_can_view_post` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `user_can_view_post`(pid INT(10), user VARCHAR(100)) RETURNS tinyint(1)
BEGIN

SELECT author, receiver, permission_type INTO @author, @receiver, @permission
FROM posts WHERE postid = pid LIMIT 1;

IF @author = user
THEN RETURN 1;
ELSEIF are_friends(@author, user) = 1 AND @permission IN ('Public','Friends', 'Friends of Friends')
	THEN RETURN 1;
ELSEIF are_fofs(@author, user) = 1 AND @permission IN ('Public', 'Friends of Friends')
	THEN RETURN 1;
ELSE RETURN 0;
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `count_comment_likes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `count_comment_likes`(In commentid int(10))
proc_main:Begin

  Select count(*)
  From likes_comments
  Where cid = commentid;

End proc_main ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `count_loc_likes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `count_loc_likes`(In activityid int(10), locationid int(10))
proc_main:Begin

  Select count(*)
  From likes_locations_activities
  Where actid = activityid And locid = locationid;

End proc_main ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `count_post_likes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `count_post_likes`(In pid int(10))
proc_main:Begin

  Select count(*)
  From likes_posts
  Where postid = pid;

End proc_main ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_friends_friends` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_friends_friends`(IN user VARCHAR(100))
BEGIN

SELECT sentby FROM friends WHERE receivedby IN (

	SELECT sentby FROM friends WHERE receivedby = p_user AND status = 'Accepted'
	UNION
	SELECT receivedby FROM friends WHERE sentby = p_user AND status = 'Accepted' 

) AND status = 'Accepted' AND receivedby <> p_user
UNION
SELECT receivedby FROM friends WHERE sentby IN (

	SELECT sentby FROM friends WHERE receivedby = p_user AND status = 'Accepted'
	UNION
	SELECT receivedby FROM friends WHERE sentby = p_user AND status = 'Accepted' 

) AND status = 'Accepted' AND sentby <> p_user;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_news_feed` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_news_feed`(
IN p_user VARCHAR(100)
)
BEGIN

-- view all posts by a user's friends or friends of friends

SELECT postid, author, receiver, caption, content, posttime, permission_type, locid, actid
FROM posts WHERE 
( -- The author or receiver are in first level of friends
	(
		(receiver IN (
			SELECT sentby FROM friends WHERE receivedby = p_user AND `status` = 'Accepted'
			UNION
			SELECT receivedby FROM friends WHERE sentby = p_user AND `status` = 'Accepted' 
		) OR 
			author IN (
			
			SELECT sentby FROM friends WHERE receivedby = p_user AND `status` = 'Accepted'
			UNION
			SELECT receivedby FROM friends WHERE sentby = p_user AND `status` = 'Accepted' 
			)
		)
	)
	AND (permission_type <> 'Private')
)
OR -- The author or receiver are in the second level of friends
(
	(
		receiver IN (

			SELECT sentby FROM friends WHERE receivedby IN (

				SELECT sentby FROM friends WHERE receivedby = p_user AND `status` = 'Accepted'
				UNION
				SELECT receivedby FROM friends WHERE sentby = p_user AND `status` = 'Accepted' 

			) AND `status` = 'Accepted' AND receivedby <> p_user
			UNION
			SELECT receivedby FROM friends WHERE sentby IN (

				SELECT sentby FROM friends WHERE receivedby = p_user AND `status` = 'Accepted'
				UNION
				SELECT receivedby FROM friends WHERE sentby = p_user AND `status` = 'Accepted' 

			) AND `status` = 'Accepted' AND sentby <> p_user



		) OR author IN (


			SELECT sentby FROM friends WHERE receivedby IN (

				SELECT sentby FROM friends WHERE receivedby = p_user AND `status` = 'Accepted'
				UNION
				SELECT receivedby FROM friends WHERE sentby = p_user AND `status` = 'Accepted' 

			) AND `status` = 'Accepted' AND receivedby <> p_user
			UNION
			SELECT receivedby FROM friends WHERE sentby IN (

				SELECT sentby FROM friends WHERE receivedby = p_user AND `status` = 'Accepted'
				UNION
				SELECT receivedby FROM friends WHERE sentby = p_user AND `status` = 'Accepted' 

			) AND `status` = 'Accepted' AND sentby <> p_user

		)
		AND (permission_type = 'Friends of Friends' OR permission_type = 'Public')
	)
)
ORDER BY posttime DESC;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_user_wallposts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_user_wallposts`(IN username VARCHAR(100), IN viewer VARCHAR(100))
BEGIN



SELECT 
postid, author, receiver, caption, content, posttime, permission_type, locid, actid
FROM posts WHERE ((author = username AND receiver = username) OR (receiver = username) )
AND (SELECT user_can_view_post(postid, viewer)) = 1
ORDER BY posttime DESC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_comment_likes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_comment_likes`(
	IN username 	VARCHAR(100),
	IN cid        int(10),
	OUT success bool
)
BEGIN
-- Check for already-existing
	SELECT 0 INTO success
	FROM likes_comments l
	WHERE l.username = username and l.cid = cid;

  If success = 0
  Then
  Delete From likes_comments
	USING l AS likes_comments
  WHERE l.username = username and l.cid = cid;
  End If;


	IF success = 1
	THEN
	INSERT INTO likes_comments (username, cid)
	VALUES (username, cid);
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_location_likes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_location_likes`(
	IN username 	VARCHAR(100),
	IN actid        int(10), 
	IN locid        int(10),
	OUT success bool
)
BEGIN
-- Check for already-existing
	SELECT 0 INTO success
	FROM likes_locations_activities l
	WHERE l.username = username and l.actid = actid and l.locid = locid;

  If success = 0
  Then
  Delete From likes_locations_activities 
	USING l AS likes_locations_activities 
  WHERE l.username = username and l.actid = actid and l.locid = locid;
  End If;


	IF success = 1
	THEN
	INSERT INTO likes_locations_activities (username, actid, locid)
	VALUES (username, actid, locid);
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_post` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_post`(
	IN author VARCHAR(100),
	IN receiver VARCHAR(100),
	IN caption TEXT,
	IN content TEXT,
	IN posttime DATETIME,
	IN permission_type VARCHAR(20),
	IN locid INT(10),
	IN actid INT(10),
	OUT id INT(10)
)
BEGIN

INSERT INTO posts (	
		
author             ,
receiver           ,
caption            ,
content            ,
posttime           ,
permission_type    ,
locid              ,
actid              
)
VALUES (
		
author             ,
receiver           ,
caption            ,
content            ,
posttime           ,
permission_type    ,
locid              ,
actid              
);

SELECT LAST_INSERT_ID() INTO id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_post_likes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_post_likes`(
	IN username 	VARCHAR(100),
	IN postid        int(10),
	OUT success bool
)
BEGIN

	DECLARE _continue INT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET _continue = 1;

-- Check for already-existing
	SELECT COUNT(*) INTO success
	FROM likes_posts l
	WHERE l.username = username and l.postid = postid;

  If success = 1
  Then
  Delete From likes_posts 
  WHERE username = username and postid = postid;
  ELSE
	INSERT INTO likes_posts (username, postid)
	VALUES (username, postid);
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_user`(
	IN username 	VARCHAR(100),
	IN email 		VARCHAR(100),
	IN firstname 	VARCHAR(100),
	IN lastname 	VARCHAR(100),
	IN gender 		TINYINT(1),
	IN street 		VARCHAR(100),
	IN state 		CHAR(2),
	IN city			VARCHAR(100),
	IN zipcode		INT(5),
	IN birthdate	DATE,
	IN pass			CHAR(32),
	OUT fail		TINYINT(1)

)
BEGIN

	DECLARE _continue INT DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET _continue = 1;

-- Check for already-existing username
	SELECT COUNT(*)>0 INTO fail
	FROM users U
	WHERE U.username = username AND U.email = email;
	
	IF fail = 0
	THEN
	INSERT INTO users (username,email,firstname,lastname,gender,street,state,city,zipcode,birthdate, pw) 
	VALUES (username,email,firstname,lastname,gender,street,state,city,zipcode,birthdate, pass);
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `populate_comment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `populate_comment`(IN commentId INT(10))
BEGIN

SELECT author, postid, posttime, `text`
FROM comments
WHERE cid = commentId;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `populate_comment_likes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `populate_comment_likes`(In commentid int(10))
proc_main:Begin

  Select username, firstname, lastname
  From likes_comments JOIN users
  Where cid = commentid;

End proc_main ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
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
SELECT author, receiver, caption, content, posttime, permission_type, locid, actid
FROM posts
WHERE postid = id;

END proc_main ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `populate_post_comments` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `populate_post_comments`(IN id int(10))
proc_main:BEGIN

  SELECT cid
  FROM comments
  WHERE postid = id;

END proc_main ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `populate_post_likes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `populate_post_likes`(In pid int(10))
proc_main:Begin

  Select LP.username, firstname, lastname
  From likes_posts LP JOIN users U ON (U.username = LP.username)
  Where postid = pid;

End proc_main ;;
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

SELECT sentby AS friend FROM friends WHERE receivedby = user AND status = 'Accepted'
UNION
SELECT receivedby AS friend FROM friends WHERE sentby = user AND status = 'Accepted';

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

-- Dump completed on 2014-05-13 13:28:25
