--Q1 Who is the senior most employee based on job title? 

select * from employee
order by levels 
desc limit 1 ;

--Q2 Which Country has most invoices?

select billing_country, count(billing_country)
from invoice
group by billing_country 
order by billing_country desc;

--Q3 What are top 3 Values of total invoice?

select invoice_id, total from invoice 
order by total desc
limit 3;

/*Q4  Which city has the best customers? We would like to throw a promotional Music Festival in the city 
we made the most money.Write a query that returns one city that has the highest sum of invoice totals.
Return both the city name & sum of all invoice totals?*/

select billing_city, Count(invoice_id), sum(total) 
from invoice 
group by billing_city 
order by Sum(total) 
desc limit 1;

/*Q5 Who is the best customer? The customer who has spent the most money will be declared the best customer. 
Write a query that returns the person who has spent the most money.*/

select 	
		c.customer_id,
		c.first_name,
		c.last_name,
		sum(i.total) as total
from customer as c
join
invoice as i
on c.customer_id = i.customer_id
group by c.customer_id
order by total desc
limit 1



