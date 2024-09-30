select *
from sales_data;

-- Data Cleaning 

-- 1 Removing Duplicates
create table sales_data2 as 
select  distinct * from sales_data;

drop table sales_data;

alter table sales_data2
rename to sales_data;

 
-- 2. Replacing Wrong Typed Words

select distinct category
from sales_data
order by 1 ;

update sales_data
set category = case
	when category = "Bgas" then "Bags"
    when category = "clohting" then "clothing"
    when category = "shoeses" then "shoes"
end
where category in ('bgas' , 'clohting','shoeses');

-- 3. Replacing Nulls

update sales_data
set price = case
	when price is null
    and quantity is not null 
    and revenue is not null 
    then revenue / quantity 
    else price
end,
quantity = case
	when quantity is null
    and price is not null 
    and revenue is not null 
    then revenue / price
    else quantity
end,
revenue = case
	when revenue is null
    and quantity is not null 
    and price is not null 
    then price * quantity
    else revenue
end
WHERE 
    (price IS NULL AND quantity IS NOT NULL AND revenue IS NOT NULL)
 OR (quantity IS NULL AND price IS NOT NULL AND revenue IS NOT NULL)
 OR (revenue IS NULL AND price IS NOT NULL AND quantity IS NOT NULL);
 
 -- 4. Formating The table Correctly 
 
update sales_data
set `date` = str_to_date(`date`,'%m/%d/%Y')
where `date` is not null;

alter table sales_data
modify `date` date;
