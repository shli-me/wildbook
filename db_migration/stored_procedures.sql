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

CREATE PROCEDURE `populate_user_friends` (IN user VARCHAR(100))
proc_main:BEGIN

SELECT sentby FROM friends WHERE receivedby = user AND status = 'Accepted'
UNION
SELECT receivedby FROM friends WHERE sentby = user AND status = 'Accepted';

END proc_main $$



DELIMITER $$

CREATE PROCEDURE `populate_post` (IN id int(10))
proc_main:BEGIN
SELECT author, receiver, text, content, posttime, permission_type, locid, actid
FROM posts
WHERE postid = id;

END proc_main $$

