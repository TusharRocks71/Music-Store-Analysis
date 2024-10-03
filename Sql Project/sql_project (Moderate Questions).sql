/*Q1  Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A. */

select distinct
		c.first_name,
		c.last_name,
		c.email,
		g.name
from customer as c
join invoice as i
on c.customer_id = i.customer_id
join invoice_line as l
on i.invoice_id = l.invoice_id
join track as t 
on l.track_id = t.track_id
join genre as g
on t.genre_id = g.genre_id
where g.name = 'Rock'
order by c.email;

/*Q2 Let's invite the artist who have wirtten the most rock music in our data set.Write a query that 
returns the Artist name and total track count of the top 10 rock bands.*/ 

select
		a.artist_id,
		a.name,
		count(a.artist_id) as no_of_songs
from artist as a
join album as b
on a.artist_id = b.artist_id
join track as t 
on b.album_id = t.album_id
join genre as g
on t.genre_id = g.genre_id 
where g.name = 'Rock'
group by a.artist_id
order by no_of_songs desc
limit 10;

/* Q3 Return all the track names that have a song length longer than the average song length.Return the
Name and Milliseconds for each track. Order by the song length with the longest songs listed first.*/

select 
		name,
		milliseconds
from track
where milliseconds > (
		select avg(milliseconds) as avg_track_length
		from track )
order by milliseconds desc;


)
;
