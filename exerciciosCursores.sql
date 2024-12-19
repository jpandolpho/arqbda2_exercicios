SET SERVEROUTPUT ON;

/*1. Exiba o nome completo e o salário de todos os funcionários que trabalham no
departamento 'Sales'.*/
DECLARE
    CURSOR cur_emps IS
        SELECT first_name,  last_name, salary
            FROM employees JOIN departments USING (department_id)
            WHERE department_name='Sales';
    v_emp_record cur_emps%ROWTYPE;
BEGIN
    OPEN cur_emps;
    LOOP
        FETCH cur_emps INTO v_emp_record;
        EXIT WHEN cur_emps%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_emp_record.first_name||' '||v_emp_record.last_name||' - '||v_emp_record.salary);
    END LOOP;
    CLOSE cur_emps;
END;

/*2. Conte quantos funcionários foram contratados após 1 de janeiro de 2005.*/
DECLARE
    CURSOR cur_emps IS
        SELECT COUNT(employee_id) as count
            FROM employees
            WHERE hire_date > TO_DATE('2005-01-01','YYYY-MM-DD');
    v_result cur_emps%ROWTYPE;
BEGIN
    OPEN cur_emps;
    LOOP
        FETCH cur_emps INTO v_result;
        EXIT WHEN cur_emps%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_result.count);
    END LOOP;
    CLOSE cur_emps;
END;

/*3. Crie um cursor explícito para listar todos os funcionários do departamento 'IT'. Exiba o
nome completo e o cargo de cada funcionário.*/
DECLARE
    CURSOR cur_ti IS
        SELECT first_name, last_name, job_title
        FROM employees JOIN jobs USING (job_id)
        WHERE department_id = (SELECT department_id
                                FROM departments
                                WHERE department_name='IT');
    v_result cur_ti%ROWTYPE;
BEGIN
    OPEN cur_ti;
    LOOP
        FETCH cur_ti INTO v_result;
        EXIT WHEN cur_ti%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_result.first_name||' '||v_result.last_name||' - '||v_result.job_title);
    END LOOP;
    CLOSE cur_ti;
END;

/*4. Crie um cursor explícito para encontrar o funcionário com o maior salário. Exiba o nome
completo e o salário desse funcionário.*/
DECLARE
    CURSOR cur_max_sal IS
        SELECT first_name, last_name, salary
        FROM employees
        WHERE salary = (SELECT MAX(salary) FROM employees);
    v_res cur_max_sal%ROWTYPE;
BEGIN
    OPEN cur_max_sal;
    LOOP
        FETCH cur_max_sal INTO v_res;
        EXIT WHEN cur_max_sal%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_res.first_name||' '||v_res.last_name||' - '||v_res.salary);
    END LOOP;
    CLOSE cur_max_sal;
END;

/*5. (Cursor FOR LOOP) Utilize um cursor FOR LOOP para exibir o nome de todos os
departamentos e seus respectivos IDs*/
DECLARE
    CURSOR cur_deptos IS
        SELECT department_id, department_name
            FROM departments;
    v_deptos_res cur_deptos%ROWTYPE;
BEGIN
    FOR v_deptos_res IN cur_deptos LOOP
        DBMS_OUTPUT.PUT_LINE(v_deptos_res.department_id||' - '||v_deptos_res.department_name);
    END LOOP;
END;

/*6. (Cursor FOR LOOP) Utilize um cursor FOR LOOP para calcular a média salarial de
todos os funcionários.*/
DECLARE 
	CURSOR cur_sal IS
		SELECT salary
			FROM employees;
	v_sum_sal employees.salary%TYPE :=0;
	v_count int := 0;
BEGIN
	FOR v_sal IN cur_sal LOOP
		v_sum_sal := v_sum_sal + v_sal.salary;
		v_count := v_count+1;
	END LOOP;
	DBMS_OUTPUT.PUT_LINE(v_sum_sal/v_count);
END;

/*7. Liste os nomes dos países da região 'Europe'.*/
DECLARE 
	CURSOR cur_europe IS
		SELECT country_name
			FROM countries
    		WHERE region_id = (SELECT region_id FROM regions WHERE region_name='Europe');
BEGIN
	FOR v_country IN cur_europe LOOP
		DBMS_OUTPUT.PUT_LINE(v_country.country_name);
	END LOOP;
END;

/*8. Encontre a quantidade de funcionários que possuem comissão.*/
DECLARE 
	CURSOR cur_employee IS
		SELECT employee_id
			FROM employees
    		WHERE commission_pct > 0;
	v_count int := 0;
BEGIN
	FOR v_emp IN cur_employee LOOP
		v_count := v_count+1;
	END LOOP;
	DBMS_OUTPUT.PUT_LINE('Existem '||v_count||' funcionários com comissão.');
END;

/*9. Crie um cursor explícito para listar o nome completo dos funcionários que iniciaram em um cargo após '01-01-2007'.*/
DECLARE 
	CURSOR cur_employee IS
		SELECT first_name||' '||last_name nome_completo
			FROM employees
    		WHERE hire_date > TO_DATE('01-01-2007','DD-MM-YYYY');
BEGIN
	FOR v_emp IN cur_employee LOOP
		DBMS_OUTPUT.PUT_LINE(v_emp.nome_completo);
	END LOOP;
END;

/*10. Crie um cursor explícito para exibir o nome do departamento e o nome completo do gerente do departamento.*/
DECLARE 
	CURSOR cur_manager IS
		SELECT first_name||' '||last_name nome_completo, department_name
			FROM employees e JOIN departments d 
                ON e.employee_id=d.manager_id;
BEGIN
	FOR v_manager IN cur_manager LOOP
		DBMS_OUTPUT.PUT_LINE(v_manager.department_name||' - '||v_manager.nome_completo);
	END LOOP;
END;

/*11. (Cursor FOR LOOP) Utilize um cursor FOR LOOP para listar todos os cargos e seus salários mínimos e máximos.*/
DECLARE 
	CURSOR cur_salary IS
		SELECT job_title, MIN(salary) minimo, MAX(salary) maximo
			FROM employees JOIN jobs USING (job_id)
    		GROUP BY job_title;
BEGIN
	FOR v_job IN cur_salary LOOP
		DBMS_OUTPUT.PUT_LINE(v_job.job_title||' - MAX:'||v_job.maximo||'; MIN:'||v_job.minimo);
	END LOOP;
END;

/*12. (Cursor FOR LOOP) Utilize um cursor FOR LOOP para exibir o email de todos os
funcionários do departamento 'Marketing'.*/
DECLARE 
	CURSOR cur_email IS
		SELECT email
			FROM employees JOIN departments USING (department_id)
    		WHERE department_name='Marketing';
BEGIN
	FOR v_emp IN cur_email LOOP
		DBMS_OUTPUT.PUT_LINE(v_emp.email);
	END LOOP;
END;

/*13. Liste os nomes de todos os funcionários que são gerentes.*/
DECLARE 
	CURSOR cur_manager IS
		SELECT first_name||' '||last_name nome_completo
			FROM employees e JOIN departments d 
                ON e.employee_id=d.manager_id;
BEGIN
	FOR v_manager IN cur_manager LOOP
		DBMS_OUTPUT.PUT_LINE(v_manager.nome_completo);
	END LOOP;
END;

/*14. Calcule a soma dos salários de todos os funcionários do departamento 'IT'.*/
DECLARE 
	CURSOR cur_salary IS
		SELECT salary
			FROM employees e JOIN departments d USING (department_id)
    		WHERE department_name='IT';
	v_sal_sum employees.salary%TYPE:=0;
                
BEGIN
	FOR v_sal IN cur_salary LOOP
		v_sal_sum := v_sal_sum + v_sal.salary;
	END LOOP;
	DBMS_OUTPUT.PUT_LINE(v_sal_sum);
END;

/*15. Crie um cursor explícito para listar os IDs e nomes dos departamentos que não possuem
gerente.*/
DECLARE 
	CURSOR cur_deptos IS
		SELECT department_id, department_name
			FROM departments
    		WHERE manager_id IS NULL;
BEGIN
	FOR v_depto IN cur_deptos LOOP
		DBMS_OUTPUT.PUT_LINE(v_depto.department_name||' - '||v_depto.department_id);
	END LOOP;
END;

/*16. Crie um cursor explícito para exibir o nome completo e a data de contratação do
funcionário mais antigo*/
DECLARE 
	CURSOR cur_old_emp IS
		SELECT first_name||' '||last_name nome_completo, hire_date
			FROM employees
    		WHERE hire_date = (SELECT MIN(hire_date) FROM employees);
BEGIN
	FOR v_emp IN cur_old_emp LOOP
		DBMS_OUTPUT.PUT_LINE(v_emp.nome_completo||' - '||v_emp.hire_date);
	END LOOP;
END;

/*17. (Cursor FOR LOOP) Utilize um cursor FOR LOOP para exibir o nome completo de cada
funcionário e o nome do seu departamento.*/
DECLARE 
	CURSOR cur_emp_dep IS
		SELECT first_name||' '||last_name nome_completo, department_name
			FROM employees JOIN departments USING (department_id);
BEGIN
	FOR v_emp IN cur_emp_dep LOOP
		DBMS_OUTPUT.PUT_LINE(v_emp.nome_completo||' - '||v_emp.department_name);
	END LOOP;
END;

/*18. (Cursor FOR LOOP) Utilize um cursor FOR LOOP para calcular o salário médio de cada
departamento.*/
DECLARE 
	CURSOR cur_dep_sal IS
		SELECT department_name name, SUM(salary) soma, COUNT(department_name) contagem
			FROM employees JOIN departments USING (department_id)
    		GROUP BY department_name;
	v_sal_mean employees.salary%TYPE;
BEGIN
	FOR v_sal IN cur_dep_sal LOOP
    	v_sal_mean := v_sal.soma/v_sal.contagem;
		DBMS_OUTPUT.PUT_LINE(v_sal.name||' - '||v_sal_mean);
	END LOOP;
END;

/*19. Liste os nomes dos países que começam com a letra 'B'.*/
DECLARE 
	CURSOR cur_countries IS
		SELECT country_name
			FROM countries
    		WHERE country_name LIKE 'B%';
BEGIN
	FOR v_country IN cur_countries LOOP
    	DBMS_OUTPUT.PUT_LINE(v_country.country_name);
	END LOOP;
END;

/*20. Liste o nome completo e o salário dos funcionários que ganham mais que a média
salarial da empresa.*/
DECLARE 
	CURSOR cur_emp IS
		SELECT first_name||' '||last_name nome_completo, salary
			FROM employees
    		WHERE salary > (SELECT AVG(salary) FROM hr.employees);
BEGIN
	FOR v_emp IN cur_emp LOOP
    	DBMS_OUTPUT.PUT_LINE(v_emp.nome_completo||' - '||v_emp.salary);
	END LOOP;
END;
