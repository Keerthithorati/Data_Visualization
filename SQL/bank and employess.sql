

/*   1) To find all records fom the table */
select * from [dbo].[Bank_Loan_Data]


/*  2) To select all the id in the table */
Select [id] from [dbo].[Bank_Loan_Data]



/*  3) To write all the emp title in a upper case, from the table */
select UPPER([emp_title]) from [dbo].[Bank_Loan_Data]



/* 4) To write all the emp title in a Lower case, from the table */
select LOWER([emp_title]) from [dbo].[Bank_Loan_Data]


/* 5) To Combine address state and application type  from the table */
select [address_state]+ [application_type] from [dbo].[Bank_Loan_Data]


/* 6) count the loans whose term is less than 60 months */
select count(*) as New_Home_owners
from [dbo].[Bank_Loan_Data] where [purpose] = 'House'


/* 7) select the emp titile whose name starts with M */

SELECT [emp_title] AS M_Named_emps
FROM [dbo].[Bank_Loan_Data] WHERE [emp_title] LIKE 'M%'


/* 8) select the emp titile whose name  ends with  k*/

SELECT [emp_title] AS K_ENDED_NameS_emps
FROM [dbo].[Bank_Loan_Data] WHERE [emp_title] LIKE '%k'


/* 9) select the emp titile whose name starts with M and ends with p */

SELECT [emp_title] AS Mp_start_end_Named_emps
FROM [dbo].[Bank_Loan_Data] WHERE [emp_title] LIKE 'M%P'

/* 10) select the emp titile whose name startsany letters from a to f */

SELECT [emp_title] AS spl_Named_emps
FROM [dbo].[Bank_Loan_Data] WHERE [emp_title] LIKE '[a-f]%'

/* 10) select the emp titile whose name dont starts any letters from a to f */

SELECT [emp_title] AS spl_Named_emps
FROM [dbo].[Bank_Loan_Data] WHERE [emp_title] LIKE '[^a-f]%'


/* 11) select the emp titile whose name  starts has M as 4th character in their name */

SELECT [emp_title] AS spl_Named_emps
FROM [dbo].[Bank_Loan_Data] WHERE [emp_title] LIKE '___M%'


/* 12) select the emp titile whose name  starts has STARTS WITH A AND ENDS IN 8 CHARACTERS */

SELECT [emp_title] AS spl_Named_emps
FROM [dbo].[Bank_Loan_Data] WHERE [emp_title] LIKE 'A________'


/* 13) select the emp titile whose name  CONTAIN NK */

SELECT [emp_title] AS spl_Named_emps
FROM [dbo].[Bank_Loan_Data] WHERE [emp_title] LIKE '%NK%'


/* 14) select all unique bank names from  emp_title */

select DISTINCT [emp_title] FROM [dbo].[Bank_Loan_Data]


/* 15) COUNT all unique bank names from  emp_title */

SELECT COUNT(DISTINCT([emp_title])) FROM [dbo].[Bank_Loan_Data]


/* 16) HIGHEST LOAN AMOUNT GIVEN   */

SELECT MAX([loan_amount]) AS HIGHEST_LOAN_Given FROM [dbo].[Bank_Loan_Data]

/* 17) lowest LOAN AMOUNT GIVEN   */

SELECT Min([loan_amount]) AS lowest_LOAN_Given FROM [dbo].[Bank_Loan_Data]

----------------------------------------------------------------------------------------------------------------------------------------------------------------------

/* 18) show us any date in dd mmm yyyy format */

select CONVERT(varchar(20),[issue_date],106)
from [dbo].[Bank_Loan_Data]

/*

date format               syntex    
dd mmm yyyy     CONVERT(varchar(20),[issue_date],106)
yyyy mm dd      CONVERT(varchar(20),[issue_date],111)
time part       CONVERT(varchar(20),[issue_date],108)

*/


/* 18) Get me the year part from the issue date */
 Select DATEPART(Year,[issue_date]) from [dbo].[Bank_Loan_Data]

 /*

date Part               syntex 
Year                   DATEPART(Year,[Column_Name])
Month                  DATEPART(Month,[Column_Name])
 */

/* 20) get system date  */
select GETDATE() AS SYSTEM_DATE

/* 21) get UTC Date  */
select GETUTCDATE() AS UTC_DATE


/* 22) Get the emp title, current date, loan issue date and  difference between them in terms of months */

select
[emp_title] as employee,
GETDATE() as Todays_date,
[issue_date] as loan_issued_date,
DATEDIFF(MM,[issue_date],GETDATE()) as time_lapsed_in_months
from [dbo].[Bank_Loan_Data]


/* 23) Get the list of all employees who issued loans in the year 2021 */

select [emp_title] from [dbo].[Bank_Loan_Data] 
where DATEPART(yyyy,[issue_date]) = 2021



/* 24) Get the list of all employees who issued loans in the year 2021, without duplicates */

select distinct [emp_title] from [dbo].[Bank_Loan_Data] 
where DATEPART(yyyy,[issue_date]) = 2021


/* 24) count list of all employees who issued loans in the year 2021, without duplicates */

select count(distinct [emp_title]) from [dbo].[Bank_Loan_Data] where DATEPART(yyyy,[issue_date]) = 2021


/* 25) Give me the list for the  issued loans, in january  in the year 2021 */

select 
[id] as Loan_Id,
[emp_title] as Issued_bank,
[issue_date] as Issued_date
from [dbo].[Bank_Loan_Data]
where month([issue_date]) = 1 and year([issue_date]) = 2021


/* 26) Give me the count for the  issued loans, in january  in the year 2021 */

select count([id]) 
from [dbo].[Bank_Loan_Data] 
where 
month([issue_date]) = 1 and year([issue_date]) = 2021


/* 27) Give me the list for the  issued loans, between 21/01/2021 to 28/07/2021 */
select ([id]) 
from [dbo].[Bank_Loan_Data] 
where [issue_date] between '2021-01-21' and '2021-07-28'


/* 28) Give me the count for the  issued loans, between 21/01/2021 to 28/07/2021 */
select count([id]) 
from [dbo].[Bank_Loan_Data] 
where [issue_date] between '2021-01-21' and '2021-07-28'


/* 29) Give me the loans list for car and credit card  */

select [id],[purpose]
from [dbo].[Bank_Loan_Data]
where [purpose] in ('car','credit card')

/* 30) Give me the loans list which doesnt include car and credit card  */

select [id],[purpose]
from [dbo].[Bank_Loan_Data]
where [purpose] not in ('car','credit card')

/* 31) Give me the count of loans list for car and credit card  */

select count([id])from [dbo].[Bank_Loan_Data]
where [purpose] in ('car','credit card')

/* 32) Give me the bank first name by trimming all other names in the right side */

/* 33) Give me the bank first name by trimming all other names in the left side */

/* 34) Give me the bank first name by with a hello in the starting */

/* 35) Give `me purpose wise loan amounts*/

select [purpose] as Purpose ,sum([loan_amount] ) as Total_Loan_amount
from [dbo].[Bank_Loan_Data] 
group by [purpose]


/* 36) Give me purpose wise loan amounts form highest to lowest*/
select [purpose] as Purpose ,sum([loan_amount] ) as Total_Loan_amount
from [dbo].[Bank_Loan_Data] 
group by [purpose]
order by sum([loan_amount]) desc


/* 37) Give me purpose,Total number of loans given under those purposes, Purpose wise loan amounts  form highest to lowest*/

select
[purpose] as Purpose, 
count([purpose]) as count_loans_purpose,
sum([loan_amount]) as Total_loan_amount
from [dbo].[Bank_Loan_Data]
Group by [purpose]
order by sum([loan_amount]) desc



/* 38) Give me purpose,Total number of loans given under those purposes, Purpose wise loan amounts  form highest to lowest which are less than 5000 loans*/

select 
[purpose] as Purpose,
count([id]) as total_number_of_loans,
sum([loan_amount]) as total_loan_amount
from [dbo].[Bank_Loan_Data]
group by [purpose]
having count([id])<5000
order by sum( [loan_amount]) desc


---------------------------------------------------------------------------------------------------------------------------------------------------------------

