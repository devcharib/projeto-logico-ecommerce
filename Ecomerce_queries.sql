show databases;
use ecommerce;
show tables;
-- tabelas
select * from Clients; -- idClient
select * from person; -- idPersonClient
select * from company; -- idCompanyClient
select * from orders; -- idOrderClient, idOrder, orderstatus
select * from payments; -- totalValue, statusPayment
select * from payform; -- typePayForm
select * from paymentsformspay; -- idpfppay, idpfppayment
select * from productorder; -- idPOproduct, idPOorder, poQuantity, poStatus
select * from clientpay; -- idClientPayClient, idClientPayPayment
select * from storageLocation;-- idLproduct, idLstorage, location
desc storageLocation;
desc productorder;
-- perguntas
-- SELECT
select * from person;
select * from product;
select distinct typePayForm from payform;
-- filtros com WHERE
select p.Fname as Nome, s.totalValue as Valor,s.statusPayment as Pagamento, o.orderStatus as Pedido
from person p, payments s, orders o
where s.idPaymentOrder = o.idOrder and p.idPersonClient = o.idOrderClient; 

select p.Fname as Nome, pa.totalValue as Valor, pf.typePayForm as TipoPagamento
from person p,orders o,payments pa, payform pf, paymentsformspay pfp
where p.idPersonClient = o.idOrderClient
    and o.idOrder = pa.idPaymentOrder
    and pa.idPayment = pfp.idPFPpayment
    and pfp.idPFPpayForm = pf.idPayForm;
-- Atributos Derivados
select concat(Fname,' ',Minit,' ',Lname) as Name_Completed from person;
select * from payments
where statuspayment = 'Pendente' or statuspayment = 'Processando';
select * from payments
where statuspayment = 'Pendente' and totalValue >= 300;
-- ORDER BY
select totalValue, statusPayment
from payments
where totalValue > 100
order by totalValue;

select totalValue, statusPayment
from payments
where totalValue > 100
order by totalValue desc;

select totalValue, statusPayment
from payments
where totalValue > 100
order by totalValue limit 3;
-- HAVING
Select Pname, category, orderStatus, poQuantity, count(*)
From product, orders, productOrder
Where idProduct = idPOproduct and idOrder = idPOorder
Group by Pname
Having count(*) >= 1;

Select totalValue, typePayForm , count(*)  
From payments , paymentsformspay, payform
Where idPayment = idPFPpayment and idPayForm = idPFPpayform
Group by typePayForm, totalValue
Having totalValue > 200;

Select Sex, count(*)
from Person
where Sex = 'M'
group by Sex
having count(*) >2;
-- JOIN 
select pname, poQuantity ,category
from product
join productOrder on  idPOproduct = idProduct;

select Pname , category
from (product join storageLocation on idProduct = idLproduct)
where location = 'RJ';

select p.Pname, po.poQuantity, o.orderStatus, p.avaliacao
from productOrder po inner join product p
				on po.idPOproduct = p.idProduct
			  inner join orders o
				on po.idPOorder = o.idOrder
where p.avaliacao >= 3;

-- Pedidos por cliente / qntd

-- select * from person; -- idPersonClient, Fname
-- select * from orders; -- idOrder, idOrderClient
-- select * from product; -- Pname, idProduct
-- select * from productorder; -- poquantity, idPOorder, idpoproduct

select p.Fname as Cliente, o.idorder as No_Pedido, pr.Pname as Produto, po.POquantity as Quantidade
from person p
join orders o on p.idPersonClient = o.idOrderClient
join productOrder po on po.idPOorder = o.idOrder
join product pr on po.idPOproduct = pr.idProduct;



-- algum vendedor tambem e fornecedor
-- select * from seller;
-- select * from supplier;

select distinct SocialName 
from seller
where CNPJ IN (select CNPJ
				  from supplier);
-- select CNPJ from supplier;
-- select CNPJ from seller;

-- fornecedores e produtos lista

-- select * from supplier; -- idSupplier, socialName
-- select * from productSupplier; -- idPsSupplier, idPsProduct
-- select * from product; -- Pname, idProduct

select s.SocialName, p.Pname, ps.quantity
from productSupplier ps
join supplier s on idSupplier = idPsSupplier
join product p on idProduct = idPsProduct;