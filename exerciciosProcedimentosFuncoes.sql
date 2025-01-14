SET SERVEROUTPUT ON;

/*1. Elabore uma função que, dado o id do empregado, retorne quantos empregados são mais antigos
que ele na empresa.*/
CREATE OR REPLACE FUNCTION count_older(
    emp_id employees.employee_id%TYPE)
RETURN NUMBER
IS
    resp NUMBER;
BEGIN
    SELECT COUNT(*) INTO resp
        FROM EMPLOYEES
        WHERE employee_id IN (
            SELECT employee_id
            FROM employees
            WHERE hire_date < (
                SELECT hire_date
                FROM employees
                WHERE employee_id=emp_id
            )
        );
    RETURN resp;
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('Existem '||count_older(100)||' funcionarios mais antigos.');
END;
/

/*2. O departamento de IT, localizado no estado americano do Texas, fica próximo de uma estação de
exploração petrolífera e, devido a uma lei regulamentada nos EUA, os funcionários devem receber
um adicional de 20% no salário devido à periculosidade.
- Elabore um procedimento que exiba na tela o nome e sobrenome do empregado e o valor do
adicional de periculosidade, considerando todos os empregados que possuem esse direito.
- Desenvolva uma função que retorne o valor do salário de um funcionário dividido pelo número de
membros de sua família. Os parâmetros de entrada devem ser o id do empregado e o número de
membros da família.
- Faça a validação do id do empregado, ou seja, verifique se o empregado existe.
- Faça o tratamento de exceção caso haja erro de divisão por zero. Neste caso, exiba mensagem de
que não há membros na família;
- Caso o número de membros da família seja um valor negativo, exiba uma mensagem de erro
usando RAISE_APPLICATION_ERROR informando que números negativos são inválidos.*/
CREATE OR REPLACE PROCEDURE show_raise
IS
    CURSOR cur_it_emps IS
        SELECT first_name||' '||last_name as nome_completo, salary
        FROM employees JOIN departments USING(department_id)
        WHERE department_name='IT';
    v_emp_values cur_it_emps%ROWTYPE;
    sal_raise employees.salary%TYPE;
BEGIN
    OPEN cur_it_emps;
    LOOP
        FETCH cur_it_emps into v_emp_values;
        EXIT WHEN cur_it_emps%NOTFOUND;
        sal_raise := v_emp_values.salary*0.2;
        DBMS_OUTPUT.PUT_LINE('Nome: '||v_emp_values.nome_completo||'; Aumento: '||sal_raise);
    END LOOP;
END;
/

EXEC show_raise;

CREATE OR REPLACE FUNCTION sal_family_member(
    emp_id employees.employee_id%TYPE,
    family_members NUMBER)
RETURN employees.salary%TYPE
IS
    v_salary employees.salary%TYPE;
    v_sal_percapita employees.salary%TYPE;
    v_check employees.employee_id%TYPE;
    application_error EXCEPTION;
BEGIN
    SELECT employee_id INTO v_check
        FROM employees WHERE employee_id=emp_id;
    SELECT salary INTO v_salary
        FROM employees WHERE employee_id=v_check;
    IF family_members>0 THEN
        v_sal_percapita := v_salary/family_members;
    ELSE
        RAISE application_error;
    END IF;
    RETURN v_sal_percapita;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Empregado inexistente.');
        RETURN -1;
    WHEN application_error THEN
        DBMS_OUTPUT.PUT_LINE('Numeros negativos sao invalidos.');
        RETURN -1;
    WHEN ZERO_DIVIDE THEN
        DBMS_OUTPUT.PUT_LINE('Erro: foi informado 0 membros para a familia.');
        RETURN -1;
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('O salario por membro da familia e: '||sal_family_member(1,-1));
END;
/

/*3. Elabore um procedimento para alterar o gerente de um departamento, passando o id do
departamento e o id do empregado que ser� seu novo gerente.
- Fa�a tratamento de exce��o para todos os par�metros, ou seja, verifique se os valores informados
como par�metros s�o v�lidos.
- Um empregado somente pode ser gerente do departamento ao qual pertence. Caso o empregado
perten�a a outro departamento, exiba uma mensagem na tela dizendo que n�o � poss�vel alterar o
gerente, pois ele deve pertencer ao mesmo departamento que gerencia.*/

CREATE OR REPLACE PROCEDURE alter_manager(
    dept_id departments.department_id%TYPE,
    emp_id employees.employee_id%TYPE)
IS
    v_dept departments.department_id%TYPE;
    v_employee employees.employee_id%TYPE;
    v_emp_dep employees.department_id%TYPE;
    application_error EXCEPTION;
BEGIN
    SELECT department_id INTO v_dept
        FROM departments
        WHERE department_id=dept_id;
    SELECT employee_id INTO v_employee
        FROM employees
        WHERE employee_id=emp_id;
    SELECT department_id INTO v_emp_dep
        FROM employees
        WHERE employee_id=v_employee;
    IF v_emp_dep=v_dept THEN
        UPDATE departments
            SET manager_id=v_employee
            WHERE department_id=v_dept;
        DBMS_OUTPUT.PUT_LINE('Altera��o realizada com sucesso.');
    ELSE
        RAISE application_error;
    END IF;
EXCEPTION
    WHEN no_data_found THEN
        DBMS_OUTPUT.PUT_LINE('Parametros de execucao invalidos.');
    WHEN application_error THEN
        DBMS_OUTPUT.PUT_LINE('Empregado deve pertencer ao departamento para poder ser gerente dele.');
END;
/

EXEC alter_manager(80,145);