--Consultar o primeiro nome, sobrenome e data de contratação dos empregados que trabalham no mesmo
--departamento que o empregado com sobrenome Zlotkey (excluindo ele próprio).
select first_name, last_name, hire_date
from employees
where department_id=(
    select department_id
    from employees
    where last_name='Zlotkey'
);

--Consultar o primeiro nome, sobrenome e data de contratação dos empregados que foram contratados depois do
--empregado com sobrenome Davies.
select first_name, last_name, hire_date
from employees
where hire_date>(
    select hire_date
    from employees
    where last_name='Davies'
);

--Consultar os sobrenomes dos empregados que são gerentes de departamento
select last_name
from employees
where exists(
    select * from departments 
    where employees.employee_id=manager_id
);
--o select feito com o exists funciona de forma combinada com o select de fora.
--a subconsulta acha pra você todos os valores que satisfazem a condição que você quer
--para então a consulta externa selecionar só a coluna que você precisa

--Consultar o sobrenome e o id do cargo dos empregados que não trabalham em departamentos que contêm a
--palavra ‘sales’ no nome do departamento.
select last_name, job_id
from employees
where department_id not in (
    select department_id
    from departments
    where department_name like '%Sales%'
);

--Consultar o sobrenome e o salário dos empregados cujo salário é menor que o salário de algum empregado com id
--de cargo ‘ST_MAN’.
select last_name, salary
from employees
where salary < any (
    select salary
    from employees
    where job_id='ST_MAN'
);    

--Consultar o sobrenome e o salário dos empregados cujo salário é maior que o salário de todos os empregados do
--departamento com id = 50.
select last_name, salary
from employees
where salary > all (
    select salary
    from employees
    where department_id=50
);    

--Consultar o primeiro nome, sobrenome e salário dos empregados que possuem o mesmo cargo que o empregado
--com sobrenome Zlotkey e ganham salário maior que ele.
select first_name, last_name, salary
from employees
where job_id=(
    select job_id
    from employees
    where last_name='Zlotkey'
) and salary > (
    select salary
    from employees
    where last_name='Zlotkey'
);    

--Consultar id de países que possuem departamentos da empresa (usar EXISTS).
select unique country_id
from locations
where exists(
    select * from departments
    where locations.location_id=location_id
);