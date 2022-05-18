use albums_db;

SHOW tables;

describe albums;

select * from albums;

select COUNT(id) from albums;
-- 31

select count(distinct artist)
from albums;
-- 23

show create table albums;
/*
'CREATE TABLE `albums` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `artist` varchar(240) DEFAULT NULL,
  `name` varchar(240) NOT NULL,
  `release_date` int DEFAULT NULL,
  `sales` float DEFAULT NULL,
  `genre` varchar(240) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1'
*/
-- primary key is id.

select min(release_date) from albums;
-- 1967

select max(release_date) from albums;
-- 2011

select * from albums
where artist = 'Pink Floyd';

select release_year from albums
where name = 'Sgt. Pepper \'s Lonely Hearts Club Band';
-- 2011

select genre from albums
where name = 'Nevermind';
-- 'Grunge, Alternative rock'

select * from albums
where release_date like '%1990%';

select * from albums
where sales < 20;

select * from albums
where genre like 'Rock%';
