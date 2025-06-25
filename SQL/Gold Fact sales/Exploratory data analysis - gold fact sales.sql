--- Database exploration =   Process of   
                           -- Understand its structure
                           -- Identify key tables, columns, and relationships
						   -- Discover data types, constraints, and sample data
						   -- Prepare for tasks like reporting, analysis, or data cleaning

    -- Explore all the objects in the database
       select * from INFORMATION_SCHEMA.TABLES

	-- what schema exits in the database?
	   Select distinct TABLE_SCHEMA from INFORMATION_SCHEMA.TABLES;

    -- Explore all the columns in the database
        select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'gold.fact_sales'

	
--- Dimensions exploration =   Process of  analyzing, understanding, and profiling dimension tables in a data warehouse or reporting database. 
                               -- helps us in understanding
							      -- Key attributes
								  -- Cardinality
								  -- data quality
								  -- are hierachies defined??
								  -- how the dimensions and facts are related/joined??

     -- Explore all the tables
        select top 3 * from [dbo].[gold.fact_sales]
        select top 3 * from [dbo].[gold.report_customers]
        select top 3 * from  [dbo].[gold.report_products]                
        select top 3 * from  [dbo].[gold.dim_customers]
        select top 3 * from   [dbo].[gold.dim_products]


    -- try understaning the data by exploring all the segments and understad cardinality and Hierarchy
           -- How many countries are involved?
               select distinct [country] from [dbo].[gold.dim_customers] -- 6 countries+ 1 n/a

    -- Explore the category of the data, which is the major division as per our data
             -- Level 1 --  How many categories??
	                        select distinct [category] from [dbo].[gold.dim_products]  -- 4 categories + 1 n/a
	         -- Level 2 --  How many sub-categories??
                            select distinct [subcategory] from [dbo].[gold.dim_products] -- 36 Sub-categories + 1 n/a
             -- Level 3 --  How many Products??
                            select distinct [product_name] from [dbo].[gold.dim_products] -- 295 Products 
             -- checking all together
                             select distinct [category],[subcategory],[product_name] from [dbo].[gold.dim_products]

--- Dates exploration =   time based Profiling to undertand 
                               -- trends, growth/loss analysis and time based reporting
							   -- by identifying the earliest and latest , we can know time boundires
     -- Find the date of first and last order
        select min([order_date]) as First_Order,Max([order_date]) as Last_order from [dbo].[gold.fact_sales]
	 -- How many years of data is avalible?
	    select datediff(Year, Min([order_date]), Max([order_date])) as Years from [dbo].[gold.fact_sales]
	 -- Check the customer age range 
	    select min([birthdate]) Oldest_customer, Max([birthdate]) as Youngest_customer from [dbo].[gold.dim_customers]
		select datediff(Year, Min([birthdate]),Getdate()) AS Oldest_customer_age, DATEDIFF(YEAR,mAX([birthdate]),GETDATE())AS Youngest_customer_age from [dbo].[gold.dim_customers]

--- Measures Exploration = Measures exploration is the process of calculating big numbers in the business
                                --- Understanding what you can analyze
								--- Know how to aggregare each measure
								--- Ensuring data consistecy
								--- Accurecy in reporting
     
	 -- Write all the important business metrics 
	     select 'Total_sales' as Measure_name, sum([sales_amount]) as Total_sales from [dbo].[gold.fact_sales]
		 union all
		 select 'Average_selling_Price' as Measure_name, avg([price]) as Avg_selling_price from [dbo].[gold.fact_sales]
		 union all
		 select 'Total_Qunatity' as Measure_name, sum([quantity]) as Total_Qunatity from [dbo].[gold.fact_sales]
		 union all
		 select 'Total_Customers' as Measure_name, count( distinct [customer_id] ) as Total_Customers from [dbo].[gold.dim_customers]
	     union all
		 select 'Total_Products' as Measure_name, count ( distinct [product_id] ) as Total_Products from [dbo].[gold.dim_products]
	     union all
		 select 'Total_Categories' as Measure_name, count (distinct [category_id] ) as Total_Categories from [dbo].[gold.dim_products]
	     union all
		 select 'Total_Sub_categories' as Measure_name, count(distinct [subcategory])  as Total_sub_categories from [dbo].[gold.dim_products]


	 --  write all the key Sales- metrics in the business
	     select 'Total_sales' as Measure_name, sum([sales_amount]) as Measure_value  from [dbo].[gold.fact_sales]
		 union all
		 select 'Total_Orders' as Measure_name, count(distinct [order_number]) as Total_Orders from [dbo].[gold.fact_sales]
		 Union all
		 select 'Total_Qunatity' as Measure_name, sum([quantity]) as Total_Qunatity_sold from [dbo].[gold.fact_sales]
		 union all
		 select 'Average_order_value' as Measure_name, ( sum([sales_amount]) / count(distinct [order_number])) as AOV from [dbo].[gold.fact_sales]
		 union all
		 select 'Average_selling_price' as Measure_name, (sum([sales_amount])/sum([quantity])) from [dbo].[gold.fact_sales]
		 
-- Magnitude measures Exploration = Measures exploration are the calculations to understand the scale of the business
                                     -- Typically summoned, counted or averaged by some scale.

     -- Find the total customers by countries
        select [country], count(distinct [customer_id]) as Total_customers
		from [dbo].[gold.dim_customers]
		group by [country]
		
	 -- Find the total customers by gender
	    select [gender], count(distinct [customer_id]) as Total_customers
		from [dbo].[gold.dim_customers]
		Group by [gender]

	 -- Find the total products by category
	    select [category],count( distinct [product_id]) as Total_products
		from [dbo].[gold.dim_products]
		group  by [category]

	 -- Find the average costs in each category
	    select [category], Avg([cost]) as Average_cost
		from [dbo].[gold.dim_products]
		group  by [category]

	 -- Find total revenue generated by each category
	    select c.[category], sum(s.[sales_amount]) as Toal_revenue
		from [dbo].[gold.dim_products] c Left join [dbo].[gold.fact_sales] s
		on c.[product_key] = s.[product_key]
		Group by c.[category]

	 -- What is the total value generated by each customer?
	    select c.[customer_id], c.[first_name],sum(s.[sales_amount]) as Total_revenue_by_customer
		from [dbo].[gold.dim_customers] c left join [dbo].[gold.fact_sales] s
		on c.[customer_key] = s.[customer_key]
		Group by c.[customer_id],c.[first_name]

	 -- What is the disturbution of items sold across countries?
	    select c.[country], sum(s.[quantity]) as Total_quantity_across_Countries
		from [dbo].[gold.dim_customers] c left join [dbo].[gold.fact_sales] s
		on c.[customer_key] = s.[customer_key]
		Group by c.[country]
		Order by sum(s.[quantity]) desc

-- Ranking analysis Exploration = Measures exploration are the calculations ordering data points based on a specific metric to identify top or bottom performers
	 -- What 5 products generate highest revenue
	    select top 5 p.[product_id], p.[product_name], sum(s.[sales_amount]) as Sales_amount
		from [dbo].[gold.dim_products] p left join [dbo].[gold.fact_sales] s
		on p.[product_key] = s.[product_key]
		group by p.[product_id], p.[product_name]
		order by sum(s.[sales_amount]) desc

		
	   -- What 5 products generate lowest revenue
	    select top 5 p.[product_id], p.[product_name], sum(isnull(s.[sales_amount],0)) as Sales_amount
		from [dbo].[gold.dim_products] p right join [dbo].[gold.fact_sales] s
		on p.[product_key] = s.[product_key]
		group by p.[product_id], p.[product_name]
		order by sum(isnull(s.[sales_amount],0)) asc 
		


     
		 
	
		 