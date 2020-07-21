show databases;

use albums_db;

select database();

show tables; 

describe albums;

show create table albums;

#The name of all albums by Pink Floyd
select name
from albums 
where artist = 'pink floyd';

#The year Sgt. Pepper's Lonely Hearts Club Band was released
select release_date
from albums
where name  = 'Sgt. Pepper\'s Lonely Hearts Club Band';

#The genre for the album Nevermind
select genre
from albums 
where name = 'Nevermind';

#Which albums were released in the 1990s
select release_date
from albums
where release_date >= 1990 and release_date <= 1999;

#Which albums had less than 20 million certified sales
select sales
from albums
where sales < 20;

#All the albums with a genre of "Rock"
select name
from albums
where genre = 'rock';

#Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?
#The query results do not include hard rock or progressive rock because it is only searching for the single word 'rock.' If we use the like function along with the symbol '%' before and after rock, we can find any and all categories that include rock.