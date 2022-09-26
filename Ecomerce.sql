-- banco ecommerce
-- drop database ecommerce;
create database ecommerce;
use ecommerce;
--
create table supplier(
	idSupplier int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(15) not null,
    contact char(11) not null,
    constraint unique_supplier unique (CNPJ)
);
-- alter table supplier auto_increment=1;
create table product(
	idProduct int auto_increment primary key,
    Pname varchar(255) not null,
    classification_kids bool default false ,
    category enum('eletrônico','vestimenta','brinquedo','Alimentos','móveis') not null,
    avaliacao float default 0,
    size varchar(10)
);
-- desc product;
-- alter table product auto_increment=1;
create table Seller(
	idSeller int auto_increment primary key,
    SocialName varchar(255) not null,
    AbstName varchar(255),
    CNPJ char(15),
    CPF char(9),
    location varchar(255),
    contact char(11) not null,
    constraint unique_cnpj_seller unique (CNPJ),
    constraint unique_cpf_seller unique (CPF)
);
-- alter table Seller auto_increment=1;
create table  productStorage(
	idProdStorage int auto_increment primary key,
    storageLocation varchar(255),
    quantity int default 0    
);
-- alter table productStorage auto_increment=1;
create table orders(
	idOrder int auto_increment primary key,
    idOrderClient int,
    orderStatus enum('Cancelado', 'Confirmado', 'Em processamento') default 'Em processamento',
    orderDescription varchar(255),
    sendValue float default 10,
    paymentCash bool default false,
    constraint fk_orders_client foreign key (idOrderClient) references Clients(idClient)
);
-- alter table orders auto_increment=1;
 create table payments(
    idPayment int,
    totalValue double not null,
    statusPayment enum('Pendente', 'Processando', 'Realizado') default 'Pendente',
    idPaymentOrder int,
    constraint fk_payments_order foreign key (idPaymentOrder) references Orders(idOrder)
);
-- 
create table clients(
	idClient int auto_increment primary key,
    DataCadastro date not null
);
-- 
create table card(
	idCard int auto_increment primary key,
    typeCard enum('Crédito','Débito') not null,
    numberCard varchar(20) not null,
    keyCard char(3),
    holder varchar(50) not null,
    dateValidity date not null
);
--
create table pix(
	idPix int auto_increment primary key,
    keyPix varchar(255) not null,
    constraint unique_pix unique (keyPix)
);
--
create table boleto(
	idBoleto int auto_increment primary key,
    BoletoNumber varchar(255) not null,
    Holder varchar(50) not null
);
--
-- *******************************
create table person(
	idPerson int auto_increment primary key,
    CPF char(11) not null,
    Fname varchar(10) not null,
    Minit char,
    Lname varchar(10) not null,
    Sex enum('M','F'),
    DateBirth date,
    Address varchar(255),
    Contact varchar(50),
    idPersonClient int,
    constraint fk_person_client foreign key (idPersonCliente) references clients(idClient),
    constraint unique_person unique (CPF)
);
--
create table company(
	idCompany int auto_increment primary key,
    CNPJ char(14) not null,
    RazaoSocial varchar(150) not null,
    Adress varchar(255),
    Contact varchar(50),
    idCompanyClient int,
    constraint fk_company_client foreign key (idCompanyCliente) references clients(idClient),
    constraint unique_company unique (CNPJ)
);
--
create table payForm(
	idPayForm int auto_increment primary key,
    typePayform enum('Cartão','Pix','Boleto'),
    idPFCard int,
    idPFPix int,
    idPFBoleto int,
    constraint fk_PayForm_Card foreign key (idPFCard) references card(idCard),
    constraint fk_PayForm_Card foreign key (idPFPix) references pix(idPix),
    constraint fk_PayForm_Card foreign key (idPFCBoleto) references boleto(idBoleto)
);
--
create table paymentsFormsPay(
    idPFPpayForm int,
    idPFPpayment int,
    constraint fk_PFP_payForm foreign key (idPFPpayForm) references payForm(idPayForm),
    constraint fk_PFP_payment foreign key (idPFPpayment) references payments(idPayment)
);
--
create table delivery(
	idDelivery int auto_increment primary key,
    statusDelivery enum('','',''),
    TrakingCode char(13) not null,
    idDeliveryPayment int,
    idDeliveryOrder int,
    constraint fk_delivery_payment foreign key (idDeliveryPayment) references payments(idPayment),
    constraint fk_delivery_orders foreign key (idDeliveryOrder) references orders(idOrder)
);
--
create table ClientPay(
	idClientPayClient int,
	idClientPayPayment int,
    constraint fk_clientepay_clients foreign key (idClientPayClient) references clients(idClient),    
    constraint fk_clientepay_payment foreign key (idClientPayPayment) references payments(idPayment)    
);
--
create table productSeller(
	idPseller int,
    idPproduct int,
    ProdQuantity int default 1,
    primary key (idPseller, idPproduct),
    constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
    constraint fk_product_product foreign key (idPproduct) references product(idProduct)
);
--
create table productOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum('Disponivel','Sem estoque') default 'Disponivel',
    primary key (idPOproduct, idPOorder),
    constraint fk_product_O_product foreign key (idPOproduct) references product(idProduct),
    constraint fk_product_O_orders foreign key (idPOorder) references orders(idOrder)
);
--
create table storageLocation(
	idLproduct int,
    idLstorage int,
    location varchar(255) not null,
    primary key (idLproduct, idLstorage),
    constraint fk_product_storageL foreign key (idLproduct) references product(idProduct),
    constraint fk_prodStorage_storageL foreign key (idLstorage) references productStorage(idProdStorage)
);
--
create table productSupplier(
	idPsSupplier int,
    idPsProduct int,
    quantity int not null,
    primary key (idPsSupplier, idPsProduct),
    constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier), 
    constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct) 
);
--
show tables;

show databases;