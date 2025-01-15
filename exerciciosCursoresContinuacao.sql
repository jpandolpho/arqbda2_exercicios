SET SERVEROUTPUT ON;

--PLSQL_5_4_Cursors with Parameters.pdf
/*1. Escreva um bloco PL/SQL que declare um cursor com um parâmetro para o número do
departamento. O cursor deve retornar o nome, o sobrenome e o salário de todos os
funcionários nesse departamento. Em seguida, escreva um loop que busque e exiba os
nomes, sobrenomes e salários. Teste o bloco PL/SQL com diferentes números de
departamento.*/
DECLARE
    CURSOR cur_search_dept (p_dept_id NUMBER) IS
        SELECT first_name, last_name, salary
            FROM employees
            WHERE department_id=p_dept_id;
    v_emp cur_search_dept%ROWTYPE;
BEGIN
    OPEN cur_search_dept(20);
    LOOP
        FETCH cur_search_dept INTO v_emp;
        EXIT WHEN cur_search_dept%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_emp.first_name||' '||v_emp.last_name||' - $'||v_emp.salary);
    END LOOP;
    CLOSE cur_search_dept;
END;
/

/*2. Escreva um bloco PL/SQL que declare um cursor com um parâmetro para um cargo. O
cursor deve retornar o nome do cargo, o salário mínimo e o salário máximo desse cargo.
Em seguida, escreva um loop que busque e exiba o nome do cargo, o salário mínimo e o
salário máximo. Teste o bloco PL/SQL com diferentes cargos.*/
DECLARE
    CURSOR cur_job_sal (p_job employees.job_id%TYPE) IS
        SELECT job_title, MIN(salary) AS minimo, MAX(salary) AS maximo
            FROM employees JOIN jobs USING(job_id)
            WHERE job_id=p_job
            GROUP BY job_title;
    v_job cur_job_sal%ROWTYPE;
BEGIN
    OPEN cur_job_sal('IT_PROG');
    LOOP
        FETCH cur_job_sal INTO v_job;
        EXIT WHEN cur_job_sal%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_job.job_title||' MIN='||v_job.minimo||' // MAX='||v_job.maximo);
    END LOOP;
    CLOSE cur_job_sal;
END;
/

/*3. Escreva um bloco PL/SQL que declare um cursor com dois parâmetros: um para o
número do departamento e outro para um salário. O cursor deve retornar o nome, o
sobrenome e o salário de todos os funcionários nesse departamento que ganham mais
do que o salário especificado. Em seguida, escreva um loop que busque e exiba os
nomes, sobrenomes e salários. Teste o bloco PL/SQL com diferentes números de
departamento e salários.*/
DECLARE
    CURSOR cur_dept_gt_salary 
        (p_dept employees.department_id%TYPE, p_sal employees.salary%TYPE) IS
        SELECT first_name, last_name, salary
            FROM employees
            WHERE department_id=p_dept AND salary>p_sal;
    v_emp cur_dept_gt_salary%ROWTYPE;
BEGIN
    OPEN cur_dept_gt_salary(60,4800);
    LOOP
        FETCH cur_dept_gt_salary INTO v_emp;
        EXIT WHEN cur_dept_gt_salary%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_emp.first_name||' '||v_emp.last_name||' - $'||v_emp.salary);
    END LOOP;
    CLOSE cur_dept_gt_salary;
END;
/