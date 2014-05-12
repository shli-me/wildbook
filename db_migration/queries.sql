
CALL `wildbook`.`populate_user`('shannon');

CALL `wildbook`.`populate_post`();

-- To sign up:
INSERT INTO users (username,email,firstname,lastname,gender,street,state,city,zipcode,birthdate) VALUES ('JohnSmith','JohnSmith@mail.com','John','Smith',1,'111 Main St.','NY','11201','1/2/1990');
INSERT INTO users (username,email,firstname,lastname,gender,street,state,city,zipcode,birthdate) VALUES ('RachelHen','RachelHen@mail.com','Rachel','Hen',0,'414 West St.','NY','10001','4/6/1985');
INSERT INTO users (username,email,firstname,lastname,gender,street,state,city,zipcode,birthdate) VALUES ('JerryPin','JerryPin@mail.com','Jerry','Pin',1,'444 Pine Ave.','NY','11217','6/2/1992');
INSERT INTO users (username,email,firstname,lastname,gender,street,state,city,zipcode,birthdate) VALUES ('PhilPen','PhilPen@mail.com','Phil','Pen',1,'112 Rainbow Ave.','NY','10003','5/19/1991');
INSERT INTO users (username,email,firstname,lastname,gender,street,state,city,zipcode,birthdate) VALUES ('AbbyGail','AbbyGail@mail.com','Abby','Gail',0,'49 Freedom Road','NY','11214','12/12/1982');


-- To write posts
INSERT INTO posts (author,receiver,text,content,posttime,permission_type) VALUES ('JerryPin','RachelHen','Hi! How\'s it going?','','4/20/2014 12:10:00AM','Friends');
INSERT INTO posts (author,receiver,text,content,posttime,permission_type) VALUES ('JerryPin','JerryPin','Today I went to the beach!','','4/21/2014 12:10:00AM','Public');
INSERT INTO posts (author,receiver,text,content,posttime,permission_type) VALUES ('PhilPen','JerryPin','Hope everything is well.','','3/10/2014 10:01:00AM','Friends of Friends');
INSERT INTO posts (author,receiver,text,content,posttime,permission_type) VALUES ('RachelHen','JerryPin','Everything\'s great!','','4/20/2014 12:12:00AM','Friends of Friends');

-- Create a location
INSERT INTO locations (name,longitude,latitude) VALUES ('Coney Island','73.9786','40.5744');

-- Edit a post (add a location to it)
UPDATE posts SET locid = 1 WHERE postid = 2;

-- To send friend request
INSERT INTO friends (sentby,receivedby,status,permission_type) VALUES ('JerryPin','RachelHen','Pending','');
INSERT INTO friends (sentby,receivedby,status,permission_type) VALUES ('JerryPin','PhilPen','Pending','');
INSERT INTO friends (sentby,receivedby,status,permission_type) VALUES ('PhilPen','AbbyGail','Pending','');
INSERT INTO friends (sentby,receivedby,status,permission_type) VALUES ('RachelHen','JohnSmith','Pending','');
INSERT INTO friends (sentby,receivedby,status,permission_type) VALUES ('RachelHen','AbbyGail','Pending','');
INSERT INTO friends (sentby,receivedby,status,permission_type) VALUES ('PhilPen','JohnSmith','Pending','');

-- To accept or ignore friend request
UPDATE friends SET status = 'Accepted' WHERE sentby='JerryPin' AND receivedby='RachelHen';
UPDATE friends SET status = 'Accepted' WHERE sentby='JerryPin' AND receivedby='PhilPen';
UPDATE friends SET status = 'Accepted' WHERE sentby='RachelHen' AND receivedby='JohnSmith';
UPDATE friends SET status = 'Accepted' WHERE sentby='RachelHen' AND receivedby='AbbyGail';
UPDATE friends SET status = 'Accepted' WHERE sentby='PhilPen' AND receivedby='JohnSmith';


-- List all friends
SELECT sentby FROM friends WHERE receivedby = @username AND status = 'Accepted'
UNION
SELECT receivedby FROM friends WHERE sentby = @username AND status = 'Accepted'

-- List friends of friends
WITH firstLevelFriends (friend) AS
( 
SELECT sentby FROM friends WHERE receivedby = @username AND status = 'Accepted'
UNION
SELECT receivedby FROM friends WHERE sentby = @username AND status = 'Accepted'
)
SELECT sentby FROM friends WHERE receivedby IN (firstLevelFriends) AND status = 'Accepted'
UNION
SELECT receivedby FROM friends WHERE sentby IN (firstLevelFriends) AND status = 'Accepted'

--View news feed
-- view all posts by a user's friends or friends of friends or anyone who posted with @keyword
WITH firstLevelFriends (friend) AS
( 
SELECT sentby FROM friends WHERE receivedby = @username AND status = 'Accepted'
UNION
SELECT receivedby FROM friends WHERE sentby = @username AND status = 'Accepted'
),
secondLevelFriends (fofs) AS
(
SELECT sentby FROM friends WHERE receivedby IN (firstLevelFriends) AND status = 'Accepted' AND receivedby <> @username
UNION
SELECT receivedby FROM friends WHERE sentby IN (firstLevelFriends) AND status = 'Accepted' AND sentby <> @username
)
SELECT * FROM posts WHERE 
(
	(
	(receiver IN (SELECT * FROM firstLevelFriends) OR author IN (SELECT * FROM firstLevelFriends))
	AND (permission_type = 'Friends')
	)
	OR 
	(
	(receiver IN (SELECT * FROM secondLevelFriends) OR author IN (SELECT * FROM secondLevelFriends))
	AND (permission_type = 'Friends of Friends')
	)
	OR permission_type = 'Public'
)
AND text CONTAINS(@keyword);





