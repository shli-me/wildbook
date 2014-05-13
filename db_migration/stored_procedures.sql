-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE PROCEDURE `populate_user` (IN user VARCHAR(100))
proc_main:BEGIN

  SELECT email, firstname, lastname, gender, street, state, city, zipcode, birthdate
  FROM users
  WHERE username = user;

END proc_main $$

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


Create Procedure `count_comment_likes` (In commentid int(10))
proc_main:Begin

  Select count(*)
  From likes_comments
  Where cid = commentid;

End proc_main $$

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

End proc_main $$

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
FROM posts WHERE author = username OR receiver = username
ORDER BY posttime DESC;

END$$
DELIMITER ;


-- FUNCTIONS
DELIMITER $$
CREATE FUNCTION `are_fofs`(user1 VARCHAR(100), user2 VARCHAR(100)) RETURNS int(11)
BEGIN

SELECT 0 INTO @fofs;

SELECT 1 INTO @fofs FROM friends
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
CREATE FUNCTION `are_friends`(user1 VARCHAR(100), user2 VARCHAR(100)) RETURNS tinyint(1)
BEGIN

SELECT 0 INTO @returnVal;

SELECT 1 INTO @returnVal FROM friends WHERE 
( (sentby = user1 AND receivedby = user2) OR (sentby = user2 AND receivedby = user1) )
AND status = 'Accepted';


RETURN @returnVal;
END$$
DELIMITER ;



