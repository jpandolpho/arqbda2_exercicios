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