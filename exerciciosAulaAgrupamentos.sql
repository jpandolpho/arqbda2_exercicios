/*1.Liste o nome completo dos funcionários e seus respectivos cargos (job_title).
Concatene o primeiro e último nome dos funcionários para obter o nome
completo.*/
select first_name||' '||last_name full_name, job_title
from employees join jobs using(job_id);

/*2.Liste os nomes dos departamentos e seus respectivos gerentes. Concatene o
primeiro e último nome dos funcionários para obter o nome do gerente. Utilize a
junção outer join entre as tabelas departments e employees através da coluna
manager_id.*/
select department_name, first_name||' '||last_name full_name
from departments left outer join employees on departments.manager_id=employees.employee_id;

--3.Liste o nome dos funcionários que trabalham no departamento de 'Sales'
select first_name||' '||last_name full_name
from employees e join departments d on e.department_id=d.department_id
where d.department_name='Sales';

/*4.Liste o nome dos funcionários que ganham mais que a média salarial da
empresa.*/
select first_name||' '||last_name full_name
from employees
where salary>(select avg(salary) from employees);

--5.Liste o nome dos funcionários que possuem o mesmo cargo que 'Steven King'.
select first_name||' '||last_name full_name
from employees
where job_id=(
    select job_id
    from employees
    where first_name='Steven' and last_name='King'
);

/*6.Liste o nome dos funcionários que foram contratados antes do gerente do
departamento de 'Sales'*/
select first_name||' '||last_name full_name
from employees
where hire_date<(
    select hire_date
    from employees join departments using (department_id)
    where employees.employee_id=departments.manager_id and department_name='Sales'
);    

/*7.Liste o nome dos departamentos que possuem mais de 5 funcionários. Utilize
GROUP BY e HAVING COUNT.*/
select department_name
from departments join employees using(department_id)
group by(department_name)
having count(department_name)>5;

--8.Liste o nome dos departamentos e o salário total de cada departamento
select department_name, sum(salary)
from departments join employees using(department_id)
group by department_name;

/*9.Liste o nome dos departamentos e o salário médio de cada departamento,
incluindo o salário médio geral da empresa. Utilize GROUP BY ROLLUP*/
select department_name, avg(salary)
from departments join employees using(department_id)
group by rollup(department_name);

/*10.Liste o nome dos departamentos, o cargo e o salário total para cada
combinação de departamento e cargo. Utilize GROUP BY CUBE*/
select department_name, job_title, sum(salary)
from departments join employees using(department_id)
     join jobs using (job_id)
group by cube(department_name, job_title);

/*11.Liste o nome dos departamentos, o cargo e o salário total para cada combinação
de departamento e cargo, incluindo totais gerais. Utilize GROUP BY GROUPING
SETS.*/
select department_name, job_title, sum(salary)
from departments join employees using(department_id)
     join jobs using (job_id)
group by grouping sets((department_name, job_title),());

/*12.Liste o nome completo dos funcionários, seus respectivos cargos e o nome de
seus gerentes. Utilize autojunção.*/
select e.first_name||' '||e.last_name employee_name, e.job_id, m.first_name||' '||m.last_name manager_name
from employees e join employees m on e.manager_id=m.employee_id;

/*13.Liste o nome dos departamentos que possuem funcionários com o cargo de
'Sales Representative'.*/
select department_name
from departments
where department_id in(
    select department_id
    from employees join jobs using (job_id)
    where job_title='Sales Representative'
);

/*14.Liste o nome dos funcionários que possuem salário superior ao do seu gerente.
Utilize autojunção*/
select e.first_name||' '||e.last_name full_name
from employees e join employees m on e.manager_id=m.employee_id
where e.salary>m.salary;

/*15.Liste o nome dos funcionários que trabalham no mesmo departamento que o
funcionário com o maior salário.*/
select first_name||' '||last_name full_name
from employees
where department_id = (
    select department_id
    from employees
    where salary = (
        select max(salary)
        from employees
    )
);

/*16.Liste o nome dos funcionários que foram contratados no mesmo dia que outro
funcionário.*/
select e.first_name||' '||e.last_name full_name
from employees e full outer join employees o on e.hire_date=o.hire_date
where e.hire_date=o.hire_date and e.employee_id!=o.employee_id;

/*17.Liste o nome dos departamentos e a quantidade de funcionários em cada
departamento, incluindo departamentos sem funcionários*/
select department_name, count(employee_id) quantidade
from departments left outer join employees using(department_id)
group by department_name
order by quantidade;

/*18.Liste o nome dos gerentes e o número de funcionários que eles gerenciam,
incluindo gerentes que não gerenciam ninguém.*/
select e.first_name||' '||e.last_name full_name, count(c.employee_id) quantidade
from departments d join employees e on d.manager_id=e.employee_id
     left join employees c on e.employee_id=c.manager_id
group by e.first_name||' '||e.last_name
order by quantidade;

/*19. Liste o nome dos departamentos, o cargo e a quantidade de funcionários para
cada combinação, incluindo totais por departamento e totais gerais*/
select department_name, job_id, count(employee_id)
from departments join employees using(department_id)
group by grouping sets((department_name, job_id),(department_name),());

/*20. Liste o nome dos departamentos, o cargo, o salário médio e o número de
funcionários para cada combinação, incluindo totais por departamento e totais
gerais. Utilize GROUP BY GROUPING SETS*/
select department_name, job_id, avg(salary), count(employee_id)
from departments join employees using(department_id)
group by grouping sets((department_name, job_id),(department_name),());

/*21. Liste o nome completo dos funcionários que têm o mesmo cargo e departamento
que 'Jennifer Whalen'.*/
select first_name||' '||last_name full_name
from employees
where job_id =(
    select job_id
    from employees
    where first_name||' '||last_name = 'Jennifer Whalen'
) and department_id=(
    select department_id
    from employees
    where first_name||' '||last_name = 'Jennifer Whalen'
);

/*22. Liste o nome dos departamentos que têm funcionários com salários superiores
a 10.000 e que também têm funcionários com salários inferiores a 5.000.*/
select unique department_name
from departments join employees using (department_id)
where salary>10000 or salary<5000

/*23. Liste o primeiro nome, o último nome e o salário dos funcionários que ganham
mais que a média salarial e trabalham no mesmo departamento*/
select e.first_name, e.last_name, e.salary
from employees e
where e.salary > (
    select avg(salary)
    from employees s
    where s.department_id=e.department_id
    group by department_id
);

/*24. Liste o nome dos departamentos que têm mais de 3 funcionários e onde o
salário médio é superior a 8.000.*/
select department_name
from departments join employees using (department_id)
group by(department_name)
having count(department_name)>3 and avg(salary)>8000;

/*25. Liste o nome dos funcionários que não são gerentes e que têm um salário
superior ao salário médio de todos os gerentes.*/
select first_name||' '||last_name full_name
from employees
where salary > (
    select avg(salary)
    from departments d join employees e on d.manager_id=e.employee_id
) and employee_id not in (
    select employee_id
    from departments d join employees e on d.manager_id=e.employee_id
);
