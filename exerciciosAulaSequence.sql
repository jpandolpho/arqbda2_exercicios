CREATE TABLE copy_employees AS (SELECT * FROM hr.employees);
CREATE TABLE copy_departments AS (SELECT * FROM hr.departments);

/*1 - Crie uma sequence chamada seq_funcionario que inicia em 207 e incrementa de 1 em
1.*/
create sequence seq_funcionario
increment by 1
start with 207;

/*2 - Insira um novo funcionário na tabela copy_employees utilizando a sequence
seq_funcionario para gerar o employee_id. Utilize dados à sua escolha para as outras
colunas.*/
insert into copy_employees
values (seq_funcionario.nextval,'Marcos','Silva','MSILVA','555.555.5555',TO_DATE('13-01-2001', 'dd-MM-yyyy'),'IT_PROG',4800, null,103,60);
select * from copy_employees;

/*3 - Crie um índice na coluna last_name da tabela copy_employees para otimizar buscas por
sobrenome.*/
create index idx_last_name on copy_employees(last_name);

/*4 - Após inserir o funcionário no exercício 2, utilize CURRVAL para exibir o valor atual da
sequence seq_funcionario.*/
select seq_funcionario.currval from dual;

/*5 - Realize uma consulta na tabela copy_employees utilizando o last_name do funcionário
inserido no exercício 2. Observe se a utilização do índice criado no exercício 3 impacta o
tempo de resposta da consulta.*/
select *
from copy_employees
where last_name like 'Silva';

/*6 - Crie uma sequence chamada seq_departamento com as seguintes características:
■ Valor inicial: 300
■ Incremento: 10
■ Valor mínimo: 10
■ Valor máximo: 9990
■ Não reinicia após atingir o valor máximo (NOCYCLE)
■ Armazena em cache 20 valores (CACHE 20)*/
create sequence seq_departamento
increment by 1
start with 300
maxvalue 9990
nocycle
cache 20;

/*7 - Insira um novo departamento na tabela copy_departments utilizando a sequence
seq_departamento para gerar o department_id. Utilize dados à sua escolha para as
outras colunas.*/
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES
( seq_departamento.nextval, 'Education', 200, 1700);

/*8 - Remova o índice criado no exercício 3*/
drop index idx_last_name;