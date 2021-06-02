# Preparação para o desenvimento da aplicação

## SQL do banco de dados

**Criação do banco de dado**

```sql

CREATE TABLE `family` (
	`id`	INTEGER PRIMARY KEY AUTOINCREMENT,
	`name`	TEXT NOT NULL
);

CREATE TABLE `shopping_list` (
	`id`	INTEGER PRIMARY KEY AUTOINCREMENT,
	`title`	TEXT,
	`description`	TEXT,
	`is_done`	INTEGER DEFAULT 0,
	`create_at`	TEXT,
	`family`	INTEGER,
	FOREIGN KEY(`family`) REFERENCES `family`(`id`)
);

CREATE TABLE `purchase_item` (
	`id`	INTEGER PRIMARY KEY AUTOINCREMENT,
	`product_name`	TEXT NOT NULL,
	`quantity`	INTEGER NOT NULL,
	`price`	REAL NOT NULL,
	`shopping_list`	INTEGER,
	FOREIGN KEY(`shopping_list`) REFERENCES `shopping_list`(`id`)
);

```

**Criação da família**

```sql
insert into family(name)
values ('Familia Lima');
```

**Seleiconar todas as famílias**
```sql
select * from family order by name;
```

**Atualizar o nome da familia**

```sql
update family
set name = 'Lima'
where id = 1;
```

**adicionar lista de compra**

```sql
insert into shopping_list(title, description, create_at, family)
values ('Compras 01-06-2021', 'Compras 01-06-2021', '01-06-2021', 1);
```

**Selecionar todas as listas de compras de uma família**

```sql
select * from shopping_list where family = 1;
```

**remover lista de compras**

```sql
delete from shopping_list where id = 2;
```

**Selecionar todas as listas de compras independente da familia**

```sql
select * from shopping_list;
```

**Atualizar dados da lista de compras**

```sql
update shopping_list
set title = 'teste',
description = 'teste'
where id = 3;
```

**Atualizar dados da lista de compras**

```sql
update shopping_list
set create_at = '30-05-2021'
where id = 3;
```

**marcar como concluída uma lista de compras**

```sql
update shopping_list
set is_done = 1
where id = 3;
```

**desmarcar como concluída uma lista de compras**

```sql
update shopping_list
set is_done = 0
where id = 3;
```

**adicionar item em uma lista de compras**

```sql
insert into purchase_item(product_name, quantity, price, shopping_list)
values ('Arroz', 4, 22.50, 1);
```

**Selecionar todos os itens da lista de compras**

```sql
select * from purchase_item where shopping_list = 1;
```

**Atualizar os dados do item**

```sql
update purchase_item
set product_name = 'Arroz integral',
quantity = 2,
price = 22.50
where id = 1;
```

**remove item de uma lista de compras**

```sql
delete from purchase_item where id = 2;
```

**calcular o total de uma lista de compras**

```sql
select sum(pi.quantity * pi.price) from shopping_list as sl inner join purchase_item pi
on sl.id = pi.shopping_list where sl.id = 1;
```