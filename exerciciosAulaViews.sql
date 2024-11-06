--criando tabela para possíveis alterações
CREATE TABLE copy_employees AS (SELECT * FROM hr.employees);

/*1 - Crie uma view chamada vw_empregados_info que exiba o nome completo
(concatenando first_name e last_name), o cargo (job_id) e o salário (salary) de todos os
empregados.*/
create or replace view vw_empregados_info
as select first_name||' '||last_name nome_completo, job_id cargo, salary salario
    from copy_employees;
select * from vw_empregados_info;

/*2 - Crie uma view chamada vw_empregados_alta_renda que mostre os detalhes dos
empregados (ID, nome completo, cargo e salário) que ganham mais de 10.000.*/
create or replace view vw_empregados_alta_renda
as select employee_id id, first_name||' '||last_name nome_completo, job_id cargo, salary salario
    from copy_employees
    where salary > 10000;
select * from vw_empregados_alta_renda;

/*3 - Crie uma view chamada vw_empregados_departamento que mostre o nome completo
do empregado, o nome do departamento (department_name) e a cidade (city) onde o
departamento está localizado. Utilize as tabelas employees, departments e locations.*/
create or replace view vw_empregados_departamento
as select first_name||' '||last_name nome_completo, department_name departamento, city cidade
    from employees join departments using (department_id)
        join locations using (location_id);
select * from vw_empregados_departamento;

/*4 - Crie uma view chamada vw_salario_medio_departamento que mostre o nome do
departamento e o salário médio dos empregados em cada departamento*/
create or replace view vw_salario_medio_departamento
as select department_name departamento, avg(salary) media_salario
    from employees join departments using (department_id)
    group by department_name;
select * from vw_salario_medio_departamento;

/*5 - Crie uma view chamada vw_empregados_ti que exiba os detalhes dos empregados
(copy_employees) que trabalham no departamento de TI (department_id = 60). Utilize
WITH CHECK OPTION para garantir que qualquer atualização feita através da view
mantenha os empregados no departamento de TI.*/
create or replace view vw_empregados_ti
as select *
    from copy_employees
    where department_id=60 with check option;
select * from vw_empregados_ti;
/*update vw_empregados_ti
set department_id=90
where employee_id=103;*/

/*6 - Crie uma view chamada vw_empregados_rh que exiba os detalhes dos empregados do
departamento de RH (department_id = 40) como somente leitura, impedindo qualquer
modificação através da view.*/
create or replace view vw_empregados_rh
as select *
    from employees
    where department_id=40 
    with read only;
select * from vw_empregados_rh;
/*update vw_empregados_rh
set department_id=90
where employee_id=203;*/

/*7 - Insira um novo empregado na view vw_empregados_ti criada no exercício 5. Verifique se
o empregado foi inserido corretamente na tabela employees.*/
insert into vw_empregados_ti
values (207,'Marcos','Silva','MSILVA','555.555.5555',TO_DATE('13-01-2001', 'dd-MM-yyyy'),'IT_PROG',4800, null,103,60);
select * from vw_empregados_ti;

/*8 - Dê um aumento de 10% para o salário do empregado inserido no exercício 7, utilizando
a view vw_empregados_ti.*/
update vw_empregados_ti
set salary=(salary*1.1);
select * from vw_empregados_ti;

/*9 - Remova o empregado inserido no exercício 7, utilizando a view vw_empregados_ti.*/
delete from vw_empregados_ti
where employee_id=207;
select * from vw_empregados_ti;

/*Tente atualizar o cargo de um empregado na view vw_empregados_ti para um cargo que
não pertence ao departamento de TI. O que acontece? Por quê?*/
update vw_empregados_ti
set job_id='HR_REP'
where employee_id=103;
--Funciona, porque o que é validado é o departamento, não o cargo