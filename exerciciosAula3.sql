--Consultar o primeiro nome, sobrenome e data de contrata��o dos empregados que trabalham no mesmo
--departamento que o empregado com sobrenome Zlotkey (excluindo ele pr�prio).
select first_name, last_name, hire_date
from employees
where department_id=(
    select department_id
    from employees
    where last_name='Zlotkey'
);

--Consultar o primeiro nome, sobrenome e data de contrata��o dos empregados que foram contratados depois do
--empregado com sobrenome Davies.
select first_name, last_name, hire_date
from employees
where hire_date>(
    select hire_date
    from employees
    where last_name='Davies'
);

--Consultar os sobrenomes dos empregados que s�o gerentes de departamento
select last_name
from employees
where exists(
    select * from departments 
    where employees.employee_id=manager_id
);
--o select feito com o exists funciona de forma combinada com o select de fora.
--a subconsulta acha pra voc� todos os valores que satisfazem a condi��o que voc� quer
--para ent�o a consulta externa selecionar s� a coluna que voc� precisa

--Consultar o sobrenome e o id do cargo dos empregados que n�o trabalham em departamentos que cont�m a
--palavra �sales� no nome do departamento.
select last_name, job_id
from employees
where department_id not in (
    select department_id
    from departments
    where department_name like '%Sales%'
);

--Consultar o sobrenome e o sal�rio dos empregados cujo sal�rio � menor que o sal�rio de algum empregado com id
--de cargo �ST_MAN�.
select last_name, salary
from employees
where salary < any (
    select salary
    from employees
    where job_id='ST_MAN'
);    

--Consultar o sobrenome e o sal�rio dos empregados cujo sal�rio � maior que o sal�rio de todos os empregados do
--departamento com id = 50.
select last_name, salary
from employees
where salary > all (
    select salary
    from employees
    where department_id=50
);    

--Consultar o primeiro nome, sobrenome e sal�rio dos empregados que possuem o mesmo cargo que o empregado
--com sobrenome Zlotkey e ganham sal�rio maior que ele.
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

--Consultar id de pa�ses que possuem departamentos da empresa (usar EXISTS).
select unique country_id
from locations
where exists(
    select * from departments
    where locations.location_id=location_id
);