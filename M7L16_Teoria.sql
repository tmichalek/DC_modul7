--1
select p.*, s.*
from products p
inner join sales s on (p.id=s.sal_prd_id)
where (p.product_man_region=1 or p.product_man_region =2)
limit 100;

--2
select p.*, 
m.region_name 
from products p
left join product_manufactured_region m 
on (p.product_man_region=m.id and m.established_year>=2012);

--3

select p.*, 
m.region_name 
from products p
left join product_manufactured_region m 
on (p.product_man_region=m.id)
where m.established_year >=2012;
--Różnica polega na tym, że w zadaniu drugim ograniczmy złączenie i pomimo, iż istnieje połączenie 
--pomiędzy tabelami, w przypadku Produkt 1 powstałego w regionie EMEA wartość region_name jest wyświetlany
--ale z wartością null. Natomiat w zadaniu 3 w wyniku zastosowania filtru rekord ten nie jest wyświetlany

--4

select p.product_name, 
    concat(extract(year from s.sal_date),'_', extract(month from s.sal_date)) as data_sprzedazy
    from sales s
    right join 
    (select products.id, products.product_name from products where products.product_quantity > 5) p 
    on s.sal_prd_id = p.id
order by 1 desc;

--5

insert into product_manufactured_region ( region_name, region_code, established_year)
values ('Arctics', null, 2020);

select p.*, pmr.*
from products p
full join product_manufactured_region pmr on p.product_man_region= pmr.id ;

--6

select p.*, pmr.*
from products p
left join product_manufactured_region pmr on p.product_man_region= pmr.id 
union
select p.*, pmr.*
from products p
right join product_manufactured_region pmr on p.product_man_region= pmr.id;

--7

    with p_quantity_over_5 as (select products.id, products.product_name from products where products.product_quantity > 5)
    select p.product_name, 
    concat(extract(year from s.sal_date),'_', extract(month from s.sal_date)) as data_sprzedazy
    from sales s
    right join p_quantity_over_5 p
    on s.sal_prd_id = p.id;

--8
delete from products p
where exists (select 1 from product_manufactured_region pmr 
            where pmr.id =p.product_man_region and pmr.region_name ='EMEA' 
            and pmr.region_code ='E_EMEA'
            );
--9
--with recursive Fibonacci (id, n) as(
--    select 0,1
--    union all 
--    select id+1, (n + coalesce((select n where id=id-1),0))
--    from fibonacci 
--    where n<100)
--    select * from Fibonacci ;

with recursive Fibonacci (id, n) as(
    select 0,1
    union all 
    select n, id+n
    from fibonacci 
    where n<100)
    select * from Fibonacci ;


   