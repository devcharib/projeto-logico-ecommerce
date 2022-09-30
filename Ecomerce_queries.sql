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
Having count(*);

-- JOIN complexas
-- Pedidos por cliente / qntd
-- algum vendedor tambem e fornecedor
-- fornecedores e produtos lista
-- 
