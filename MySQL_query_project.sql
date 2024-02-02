USE painting

#Data extract
SELECT
	s.work_id,
	w.artist_id,
	w.museum_id,
	w.name,
	w.`style`,
	s.subject,
	ps.sale_price,
	ps.regular_price,
	m.country 
FROM `work` w
JOIN subject s ON s.work_id = w.work_id
JOIN museum m ON m.museum_id = w.museum_id
JOIN artist a ON a.artist_id = w.artist_id
JOIN product_size ps ON ps.work_id = w.work_id 
GROUP BY 
	s.work_id,
	w.artist_id,
	w.museum_id,
	w.name,
	w.`style`,
	s.subject,
	ps.sale_price,
	ps.regular_price,
	m.country 


-- KPI Requirements

#Total style
SELECT count(DISTINCT `style`) AS total_style FROM worktable_new wn 

#Total subject
SELECT count(DISTINCT subject) AS total_subject FROM worktable_new wn 

#Total museum
SELECT count(DISTINCT museum_id) AS total_museum FROM worktable_new wn 

#Total country
SELECT count(DISTINCT country) AS total_country FROM worktable_new wn 

#Total artist
SELECT count(DISTINCT a.full_name) AS total_artist FROM artist a
JOIN worktable_new wn ON wn.artist_id = a.artist_id 

#Total income
SELECT sum(sale_price) AS total_income FROM worktable_new wn 


-- Finding total sales (qty) by style
SELECT 
	`style`,
	count(artist_id) AS total_sales
FROM worktable_new wn 
GROUP BY `style`
ORDER BY total_sales DESC;


-- Finding total sales (qty) by country
SELECT
	country,
	count(country) AS total_sales
FROM worktable_new wn 
GROUP BY country
ORDER BY total_sales DESC;


-- Finding total sales (qty) by museum 
SELECT
	m.name,
	m.country,
count(wn.work_id) AS total_sales 
FROM worktable_new wn
JOIN museum m ON m.museum_id = wn.museum_id 
GROUP BY
	m.name,
	m.country
ORDER BY 
	country DESC,
	total_sales DESC;


-- Finding total sales (qty) by subject
SELECT
	subject,
	count(`style`) AS total_sales 
FROM worktable_new wn
GROUP BY subject
ORDER BY total_sales DESC;


-- Finding total income ($) by Style
SELECT
	`style`,
	sum(sale_price) AS total_income 
FROM worktable_new wn 
GROUP BY `style`
ORDER BY total_income DESC;


-- Finding total income ($) by Subject
SELECT
	subject,
	sum(sale_price) AS total_income
FROM worktable_new wn
GROUP BY subject
ORDER BY total_income DESC;


-- Finding most highest income by an artist
SELECT
	wn.artist_id,
	a.full_name,
	a.nationality,
	count(wn.`style`) AS total_qty,
	sum(wn.sale_price) AS total_income
FROM worktable_new wn
JOIN artist a ON a.artist_id = wn.artist_id
GROUP BY
	wn.artist_id,
	a.full_name,
	a.nationality
ORDER BY 
	total_qty DESC,
	total_income









