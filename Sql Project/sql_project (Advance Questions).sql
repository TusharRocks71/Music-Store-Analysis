/* Q1 Find how much amount spent by each customer on artists? Write a query to return customer name, 
artist name and total spent. */

select distinct
		c.first_name,
		c.last_name,
		a.name,
		sum(i.quantity*i.unit_price) as total_amount_spent
from customer as c
join invoice as b 
on c.customer_id = b.customer_id
join invoice_line as i
on i.invoice_id = b.invoice_id
join track as t 
on i.track_id = t.track_id
join album as e 
on e.album_id = t.album_id
join artist as a 
on a.artist_id = e.artist_id
group by c.first_name,
		 c.last_name,
		 a.name
order by total_amount_spent desc ;

/* Q2 We want to find out the most popular music Genre for each country. We determine the 
most popular genre as the genre with the highest amount of purchases. Write a query 
that returns each country along with the top Genre. For countries where the maximum
number of purchases is shared return all Genres.*/

with Most_popular_genre as (
select 
		count(i.quantity) as total_quantity,
		c.country,
		g.name,
		g.genre_id,
		Row_Number() over(partition by c.country 
		order by count(i.quantity)desc) as rowno 
from invoice_line as i
join track as  t
on i.track_id = t.track_id
join genre as g
on t.genre_id = g.genre_id
join invoice as io
on io.invoice_id = i.invoice_id
join customer as c 
on c.customer_id = io.customer_id
group by c.country,
		 g.name,
		 g.genre_id
order by c.country,
		 total_quantity desc
)
select * from Most_popular_genre
where rowno<=1;

/* Q3 Write a query that determines the customer that has spent the most on music for each country. 
Write a query that returns the country along with the top customer and how much they spent. 
For countries where the top amount spent is shared, provide all customers who spent this amount. */

with Most_Spent_amount as (
select c.customer_id,
	   c.first_name,
	   c.last_name,
	   i.billing_country,
	   SUM(i.total) AS total_spending,
	   ROW_NUMBER() over(partition by i.billing_country order by sum(total) desc) as RowNo 
from invoice as i 
join customer as c 
on c.customer_id = i.customer_id
group by 
		c.customer_id,
	    c.first_name,
	    c.last_name,
	    i.billing_country
order by 
		 i.billing_country asc,
		 total_spending DESC
)
select * from Most_Spent_amount 
where RowNo<=1;

