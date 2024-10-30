/*Desafio
Como analisar o tempo de empresa dos
funcionários e categorizá-los em "Novatos",
"Experientes" e "Veteranos".*/
select first_name || ' ' || last_name nome_completo, hire_date,
    case
        when months_between(sysdate,hire_date) < 214 then 'Novato'
        when months_between(sysdate,hire_date) between 214 and 261 then 'Experiente'
        else 'Veterano'
    end as experiencia
from employees
order by hire_date;

/*1. Quais funcionários trabalham em departamentos localizados nos EUA e também
possuem histórico em departamentos localizados também nos EUA? Utilize o
operador INTERSECT para encontrar a interseção entre duas consultas que selecionam os
funcionários com base na localização atual e no histórico de trabalho*/
select employee_id
from employees e join departments d on e.department_id=d.department_id
    join locations l on l.location_id=d.location_id
    join countries c on c.country_id=l.country_id
where c.country_name='United States of America'
intersect
select employee_id
from job_history j join departments d on j.department_id=d.department_id
    join locations l on l.location_id=d.location_id
    join countries c on c.country_id=l.country_id
where c.country_name='United States of America';

/*2. Exiba os nomes dos países que possuem escritórios mas não possuem
funcionários. Utilize o operador MINUS para encontrar os países que estão na tabela
locations mas não na tabela employees (através da junção com departments)*/
select country_name
from countries c
minus
select country_name
from countries c join locations l on c.country_id=l.country_id
    join departments d on l.location_id=d.location_id
    join employees e on e.department_id=d.department_id;
    
/*3. Liste todos os nomes e sobrenomes dos funcionários, combinando os resultados
das tabelas employees e job_history. Demonstre a diferença entre UNION e UNION ALL
neste caso.*/
select first_name, last_name
from employees
union
select first_name, last_name
from employees e join job_history j on e.employee_id=j.employee_id
order by last_name;
select first_name, last_name
from employees
union all
select first_name, last_name
from employees e join job_history j on e.employee_id=j.employee_id
order by last_name, first_name;

/*4. Crie uma consulta que liste o nome de todos os funcionários que possuem comissão
e o valor da comissão formatado como "Sem Comissão" caso seja nulo. Utilize a
função TO_CHAR e CASE ou NVL para formatar o valor da comissão.*/
select first_name || ' ' || last_name nome_completo, 
    case
        when commission_pct is NULL then 'Sem Comissão'
        else TO_CHAR(commission_pct)
    end comissao
from employees;

/*5. Quais funcionários ganham mais do que a média salarial do departamento 'Sales'?
Utilize uma subconsulta na cláusula WHERE para obter a média salarial do departamento
e comparar com o salário de cada funcionário.*/
select first_name || ' ' || last_name nome_completo
from employees
where salary > (
    select avg(salary)
    from employees join departments using (department_id)
    where department_name='Sales'
);

/*6. Liste os departamentos que possuem pelo menos um funcionário com salário
superior a 10000. Utilize uma subconsulta com ANY ou EXISTS na cláusula WHERE para
verificar a existência de funcionários com alto salário em cada departamento.*/
select unique department_name
from departments join employees using (department_id)
where salary > 10000;
--não é o jeito certo de fazer, verificar no gabarito

/*7. Exiba os nomes dos funcionários que possuem o mesmo cargo que 'Steven King'.
Utilize uma subconsulta na cláusula WHERE para obter o cargo de 'Steven King' e
comparar com o cargo de outros funcionários.*/
select first_name || ' ' || last_name nome_completo
from employees join jobs using (job_id)
where job_title = (
    select job_title
    from jobs join employees using (job_id)
    where first_name || ' ' || last_name='Steven King'
);

/*8. Liste os funcionários que começaram a trabalhar na empresa antes de qualquer
funcionário do departamento 'IT'. Utilize uma subconsulta com ALL na cláusula WHERE
para comparar a data de contratação dos funcionários com as datas de contratação de
todos os funcionários do departamento 'IT'*/
select first_name || ' ' || last_name nome_completo
from employees
where hire_date < all (
    select hire_date
    from employees join departments using (department_id)
    where department_name='IT'
);

/*9. Encontre os departamentos que possuem a menor média salarial. Utilize uma
subconsulta na cláusula HAVING para comparar a média salarial de cada departamento
com a menor média salarial da empresa*/
select department_name
from departments join employees using (department_id)
group by department_name
having avg(salary) < (
    select avg(salary)
    from employees
);

/*10. Utilizando a cláusula WITH, crie uma consulta que liste os funcionários que
trabalham no departamento 'Sales' e que possuem um salário superior à média
salarial de todos os funcionários que já trabalharam nesse departamento (incluindo
histórico na tabela job_history).*/
with gtrAvgEmployees as(
    select first_name || ' ' || last_name nome_completo
    from employees
    where department_id = ( select department_id from departments where department_name='Sales')
        and salary > (
            select avg(salary)
            from employees e left outer join job_history j using (employee_id)
                join departments d on e.department_id=d.department_id
            where department_name='Sales' and (d.department_id=e.department_id or d.department_id=j.department_id)
    )
);

/*11. Exiba o nome completo dos funcionários, o nome do departamento e a cidade onde
o departamento está localizado. Utilize o INNER JOIN para combinar as tabelas
employees, departments e locations.*/
select first_name || ' ' || last_name nome_completo, department_name, city
from employees inner join departments using (department_id)
    inner join locations using (location_id);
    
/*12. Liste todos os departamentos e o número de funcionários em cada um, incluindo
departamentos sem funcionários. Utilize o LEFT OUTER JOIN entre departments e
employees para incluir departamentos sem funcionários na listagem.*/
select department_name, count(employee_id)
from departments left outer join employees using (department_id)
group by (department_name);

/*13. Liste o nome completo dos funcionários, o nome do cargo e o nome do
departamento, incluindo funcionários sem departamento e departamentos sem
funcionários. Utilize o FULL OUTER JOIN entre as tabelas employees e departments para
exibir todas as informações*/
select first_name || ' ' || last_name nome_completo, job_title, department_name
from employees full outer join departments using (department_id)
    join jobs using (job_id)

/*14. Quais funcionários já trabalharam em mais de uma função? Utilize subconsultas e
GROUP BY na cláusula HAVING para contar o número de funções em que cada
funcionário já trabalhou.*/
select unique first_name || ' ' || last_name nome_completo
from employees join job_history using (employee_id)
--não é o jeito certo de fazer isso

/*15. Crie uma consulta que liste os nomes dos funcionários que não possuem histórico
de mudança de cargo. Utilize NOT EXISTS para verificar a inexistência de registros na
tabela job_history para cada funcionário.*/
select first_name || ' ' || last_name nome_completo
from employees e
where not exists (
    select 1
    from job_history j 
    where j.employee_id=e.employee_id
);