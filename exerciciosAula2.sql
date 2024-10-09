--Recuperar o primeiro nome e o sobrenome dos funcionários com salário maior que 5000;
select first_name, last_name
from employees
where salary>5000;

--Recuperar o primeiro nome e o sobrenome dos funcionários cujos salários estejam dentro da faixa de 8000 a 10000
select first_name, last_name
from employees
where salary>=8000 and salary<=10000;

--Recuperar o sobrenome, telefone e o email dos funcionários com job_title = ‘Programmer’
select last_name, phone_number, email
from employees e join jobs j on e.job_id=j.job_id
where j.job_title='Programmer';

--Recuperar o primeiro nome e o sobrenome dos funcionários do departamento com nome ‘Marketing’;
select first_name, last_name
from employees e join departments d on e.department_id=d.department_id
where d.department_name='Marketing';

--Recuperar todos os dados das localizações situadas no país de nome ‘Canada’
select l.*
from locations l join countries c on l.country_id = c.country_id
where c.country_name='Canada';

--Recuperar os nomes dos países localizados na região ‘Europe’.
select c.country_name
from countries c join regions r on c.region_id=r.region_id
where r.region_name='Europe';

--Para cada departamento, recuperar o nome do departamento e o sobrenome do seu gerente
select department_name, last_name
from departments d join employees e on d.manager_id=e.employee_id;

--Para cada departamento, recuperar o nome do departamento e sua cidade
select department_name, city
from departments natural join locations;

--Para cada departamento, recuperar o nome do departamento, sua cidade e o nome do país
select department_name, city, country_name
from departments d join locations l on d.location_id=l.location_id join countries c on l.country_id=c.country_id;

--Para cada departamento, recuperar o nome do departamento, sua cidade e o nome do país, para países que contenham ‘United’ no nome
select department_name, city, country_name
from departments d join locations l on d.location_id=l.location_id join countries c on l.country_id=c.country_id
where c.country_name like '%United%';

--Recuperar o primeiro nome, o sobrenome e o email dos funcionários que trabalham em departamentos localizados na região = ‘Europe’
select first_name, last_name, email
from employees e join departments d on e.department_id=d.department_id
     join locations l on d.location_id=l.location_id
     join countries c on l.country_id=c.country_id
     join regions r on c.region_id=r.region_id
where region_name='Europe';