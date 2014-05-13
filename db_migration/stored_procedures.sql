DELIMITER $$

CREATE PROCEDURE `populate_search1` (search VARCHAR(100))
BEGIN

  SELECT username
  FROM users
  WHERE firstname REGEXP search || lastname REGEXP search;

END $$

DELIMITER $$

CREATE PROCEDURE `populate_search2` (IN search VARCHAR(100))
    proc_main:BEGIN

    SELECT locid
    FROM locations
    WHERE name REGEXP search;

  END proc_main $$

DELIMITER $$

CREATE PROCEDURE `populate_user_friends` (IN user VARCHAR(100))
proc_main:BEGIN

  SELECT sentby FROM friends WHERE receivedby = user AND status = 'Accepted'
  UNION
  SELECT receivedby FROM friends WHERE sentby = user AND status = 'Accepted';

END proc_main $$

DELIMITER $$


CREATE DEFINER=`root`@`localhost` PROCEDURE `count_comment_likes`(In commentid int(10))
proc_main:Begin

  Select count(*)
  From likes_comments
  Where cid = commentid;

End proc_main$$
DELIMITER ;

DELIMITER $$
Create Procedure `populate_comment_likes` (In commentid int(10))
proc_main:Begin

  Select username, firstname, lastname
  From likes_comments JOIN users
  Where cid = commentid;

End proc_main $$

DELIMITER $$

Create Procedure `count_loc_likes` (In activityid int(10), locationid int(10))
proc_main:Begin

  Select count(*)
  From likes_locations_activities
  Where actid = activityid And locid = locationid;

End proc_main$$
DELIMITER ;

DELIMITER $$
Create Procedure `populate_loc_likes` (In activityid int(10), locationid int(10))
proc_main:Begin

  Select username, firstname, lastname
  From likes_locations_activities JOIN users
  Where actid = activityid And locid = locationid;

End proc_main $$

DELIMITER $$
Create Procedure `populate_loc` (In locationid int(10))
    proc_main:Begin

    Select locid, name, longitude, latitude
    From locations
    Where locid = locationid;

  End proc_main $$

DELIMITER $$

Create Procedure `count_post_likes` (In pid int(10))
proc_main:Begin

  Select count(*)
  From likes_posts
  Where postid = pid;

End proc_main $$

Create Procedure `populate_post_likes` (In pid int(10))
proc_main:Begin

  Select username, firstname, lastname
  From likes_posts JOIN users
  Where postid = pid;

End proc_main $$

DELIMITER $$

CREATE PROCEDURE `populate_post` (IN id int(10))
proc_main:BEGIN

  SELECT author, receiver, text, content, posttime, permission_type, locid, actid
  FROM posts
  WHERE postid = id;

END proc_main $$

DELIMITER $$
CREATE PROCEDURE `insert_user`(
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
	IN password		CHAR(32),
	OUT success bool
)
BEGIN
-- Check for already-existing username
	SELECT 0 INTO success 
	FROM users U
	WHERE U.username = username OR U.email = email;
	
	IF success = 1
	THEN
	INSERT INTO users (username,email,firstname,lastname,gender,street,state,city,zipcode,birthdate, `password`) 
	VALUES (username,email,firstname,lastname,gender,street,state,city,zipcode,birthdate, password);
	END IF;

END$$

DELIMITER $$
CREATE PROCEDURE `insert_comment_likes`(
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

END$$




DELIMITER $$
CREATE PROCEDURE `insert_location_likes`(
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

END$$

DELIMITER $$
CREATE PROCEDURE `insert_post_likes`(
	IN username 	VARCHAR(100),
	IN postid        int(10),
	OUT success bool
)
BEGIN
-- Check for already-existing
	SELECT 0 INTO success
	FROM likes_posts l
	WHERE l.username = username and l.postid = postid;

  If success = 0
  Then
  Delete From likes_posts 
	USING l AS likes_posts 
  WHERE l.username = username and l.postid = postid;
  End If;


	IF success = 1
	THEN
	INSERT INTO likes_comments (username, postid)
	VALUES (username, postid);
	END IF;

END$$


DELIMITER $$
CREATE PROCEDURE `get_friends_friends`(IN user VARCHAR(100))
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

END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `get_news_feed`(
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


END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE `get_user_wallposts`(username VARCHAR(100))
BEGIN

SELECT 
postid, author, receiver, caption, content, posttime, permission_type, locid, actid
FROM posts WHERE ((author = username AND receiver = username) OR (receiver = username) )
AND (SELECT user_can_view_post(postid, viewer)) = 1
ORDER BY posttime DESC;

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_comment_likes`(
	IN username 	VARCHAR(100),
	IN cid        int(10),
	OUT success bool
)
BEGIN
-- Check for already-existing
	SELECT COUNT(*) INTO success
	FROM likes_comments l
	WHERE l.username = username and l.cid = cid;

  If success = 1
  Then
  Delete From likes_comments
  WHERE username = username and cid = cid;
  End If;


	IF success = 0
	THEN
	INSERT INTO likes_comments (username, cid)
	VALUES (username, cid);
	END IF;

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_location_likes`(
	IN username 	VARCHAR(100),
	IN actid        int(10),  -- nullable
	IN locid        int(10),  -- nullable
	OUT success bool
)
BEGIN
-- Check for already-existing
	SELECT COUNT(*) INTO success
	FROM likes_locations_activities l
	WHERE l.username = username and l.actid = actid and l.locid = locid;

  If success <> 0
  Then
	  Delete From likes_locations_activities 
		USING l AS likes_locations_activities 
	  WHERE l.username = username and l.actid = actid and l.locid = locid;
  ELSE
	INSERT INTO likes_locations_activities (username, actid, locid)
	VALUES (username, actid, locid);
END IF;

END$$
DELIMITER ;

DELIMITER $$
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

END$$
DELIMITER ;

DELIMITER $$
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

END$$
DELIMITER ;

DELIMITER $$
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

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `populate_comment`(IN commentId INT(10))
BEGIN

SELECT author, postid, posttime, `text`
FROM comments
WHERE cid = commentId;

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `populate_comment_likes`(In commentid int(10))
proc_main:Begin

  Select username, firstname, lastname
  From likes_comments JOIN users
  Where cid = commentid;

End proc_main$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `populate_post`(IN id int(10))
proc_main:BEGIN
SELECT author, receiver, caption, content, posttime, permission_type, locid, actid
FROM posts
WHERE postid = id;

END proc_main$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `populate_post_comments`(IN id int(10))
proc_main:BEGIN

  SELECT cid
  FROM comments
  WHERE postid = id;

END proc_main$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `populate_post_likes`(In pid int(10))
proc_main:Begin

  Select LP.username, firstname, lastname
  From likes_posts LP JOIN users U ON (U.username = LP.username)
  Where postid = pid;

End proc_main$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `populate_user`(IN user VARCHAR(100))
BEGIN
SELECT email, firstname, lastname, gender, street, state, city, zipcode, birthdate
FROM users
WHERE username = user;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `populate_user_friends`(IN user VARCHAR(100))
proc_main:BEGIN

SELECT sentby AS friend FROM friends WHERE receivedby = user AND status = 'Accepted'
UNION
SELECT receivedby AS friend FROM friends WHERE sentby = user AND status = 'Accepted';

END proc_main$$
DELIMITER ;

-- ~~~@@@@@@@@@@@@@@@@@@@@@@@@@@ FUNCTIONS @@@@@@@@@@@@@@@@@@@@@@@@@@@@@~~~
DELIMITER $$
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
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `are_friends`(user1 VARCHAR(100), user2 VARCHAR(100)) RETURNS tinyint(1)
BEGIN

SELECT COUNT(*) INTO @returnVal FROM friends WHERE 
( (sentby = user1 AND receivedby = user2) OR (sentby = user2 AND receivedby = user1) )
AND status = 'Accepted';


RETURN @returnVal;
END$$
DELIMITER ;

DELIMITER $$
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

END$$
DELIMITER ;
