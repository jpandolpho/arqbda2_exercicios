--Consultar sobrenome e salário dos empregados cujo título do cargo é ‘Sales Representative’ ou
--‘Stock Clerk’;
select last_name, salary
from employees e inner join jobs j on e.job_id=j.job_id
where j.job_title='Sales Representative' or j.job_title='Stock Clerk';

--Consultar os nomes dos países e os nomes das regiões onde estão localizados;
select c.country_name, r.region_name
from countries c inner join regions r on c.region_id=r.region_id;

--Consultar o nome do departamento e sobrenome de seu gerente, considerando gerentes de
--departamento com salário menor que 10000
select d.department_name, e.last_name
from departments d inner join employees e on d.manager_id=e.employee_id
where e.salary<10000;

--Consultar primeiro nome e sobrenome dos empregados que trabalham em departamentos
--localizados em cidades cujo nome inicia-se com a letra S;
select e.first_name, e.last_name
from employees e inner join departments d on e.department_id=d.department_id
    inner join locations l on d.location_id=l.location_id
where l.city like 'S%';

--Consultar sobrenome e nome do departamento para os empregados que trabalham em
--departamentos localizados na região com nome ‘Europe’
select e.last_name, d.department_name
from employees e inner join departments d on e.department_id=d.department_id
    inner join locations l on d.location_id=l.location_id
    inner join countries c on l.country_id=c.country_id
    inner join regions r on c.region_id=r.region_id
where r.region_name='Europe';    

--Faça uma consulta para elaborar um relatório dos empregados e seus respectivos gerentes
--contendo sobrenome do empregado, id de seu cargo (job_id), sobrenome do seu gerente e id do
--cargo (job_id) do gerente;
select e.last_name, e.job_id, m.last_name as manager_last, m.job_id as manager_job
from employees e inner join employees m on e.manager_id=m.employee_id;

--Para todos os departamentos cadastrados, mesmo para aqueles que não tenham gerente,
--consulte o nome do departamento e o sobrenome de seu gerente;
select d.department_name, e.last_name
from departments d left outer join employees e on d.manager_id=e.employee_id;

--Considerando o histórico de cargos (tabela JOB_HISTORY), consulte sobrenome do
--empregado, id de cargo (job_id), data de início e data de encerramento registrados no histórico,
--considerando todos empregados cadastrados, incluindo também aqueles que não possuem
--registro no histórico de cargos.
select e.last_name, e.job_id, h.start_date, h.end_date
from job_history h full outer join employees e on h.employee_id=e.employee_id
order by e.last_name, h.start_date;