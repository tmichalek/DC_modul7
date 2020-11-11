--1
--Przy tym zadaniu mam dylemat bo połączenie tabel bao, bat tba i users jest przez tabele
--transaction w polu id_user jest null
select bao.owner_name,
       bao.owner_desc,
       bat.ba_type,
       bat.ba_desc,
       bat.active,
       tba.bank_account_name, 
       u.user_login 
 from bank_account_owner bao inner join
      bank_account_types bat on (bao.id_ba_own=bat.id_ba_own) inner join 
      transaction_bank_accounts tba on (bat.id_ba_type = tba.id_ba_typ) inner join
      transactions t on (tba.id_trans_ba=t.id_trans_ba) inner join
      users u on (t.id_user=u.id_user)
      where u.user_name ='Janusz Kowalski';
      
  --2
  select tc.category_name,
         ts.subcategory_name
    from transaction_category tc inner join transaction_subcategory ts 
    on (tc.id_trans_cat=ts.id_trans_cat)
    where tc.active ='1' and ts.active ='1'
    order by tc.id_trans_cat; 
    
  --3
select * from transactions 
 where id_trans_cat ='1' and (extract (year from transaction_date))='2016';
 
select * from transactions t inner join transaction_category tc on (t.id_trans_cat=tc.id_trans_cat)
 where tc.category_name ='JEDZENIE' and (extract (year from transaction_date))='2016';
 
 --4
 insert into transaction_subcategory (id_trans_cat, subcategory_name, subcategory_description, active, insert_date, update_date)
  values ((select tc.id_trans_cat from transaction_category tc where tc.category_name='JEDZENIE'),'Owoce', 'Owoce', default , now(), now());
 
 --5
update transactions set id_trans_subcat =(select id_trans_subcat from transaction_subcategory ts
                                            where ts.subcategory_name='Owoce')                                                                                      
    where id_trans_cat =(select tc.id_trans_cat from transaction_category tc where tc.category_name='JEDZENIE') and id_trans_subcat =-1;         
  

update transactions set id_trans_subcat =(select id_trans_subcat from transaction_subcategory
                                            where exists (select 1 from transaction_subcategory ts  
                                             where ts.subcategory_name='Owoc') limit 1)  
  where id_trans_cat =(select tc.id_trans_cat from transaction_category tc where tc.category_name='JEDZENIE') and id_trans_subcat =-1;         
  
  -- Tu mam kolejne pytanie (zak?adam, ?e ?le napisa?em to zapytanie), chodzi mi o to, ?e przy skladni exist w momencie
  -- gdy warunek nie jest spe?niony przy update wstawia null ? chodzi?o mi o to, ?e w drugim zapytaniu zrobi?em liter�wk? i w tym momencie
  -- ?eby nie wstawia? nic
  
 --6
  
 select 
 tc.category_name,
 ts.subcategory_name,
 tt.transaction_type_name,
 t.transaction_date,
 t.transaction_value
 from transaction_type tt 
    inner join transactions t on(tt.id_trans_type=t.id_trans_type)
    inner join transaction_category tc on (tc.id_trans_cat=t.id_trans_cat) 
    inner join transaction_subcategory ts on (tc.id_trans_cat= ts.id_trans_cat) 
    inner join transaction_bank_accounts tba on (t.id_trans_ba=tba.id_trans_ba) 
    inner join bank_account_types bat on (bat.id_ba_type=tba.id_ba_typ)
    inner join bank_account_owner bao on (bao.id_ba_own = bat.id_ba_own )
 where bao.owner_name ='Janusz i Gra?ynka' and bat.ba_type like 'OSZCZ%' and (extract (year from transaction_date))='2020';
    

