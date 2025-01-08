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
BEGIN
    SELECT employee_id INTO v_check
        FROM employees WHERE employee_id=emp_id;
    IF v_check=emp_id THEN
        SELECT salary INTO v_salary
            FROM employees WHERE employee_id=v_check;
        IF family_members>0 THEN
            v_sal_percapita := v_salary/family_members;
        ELSE
            RAISE application_error;
        END IF;
    ELSE
        v_sal_percapita :=0;
        RAISE no_data_found;
    END IF;
    RETURN v_sal_percapita;
/*EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Empregado inexistente.');
    WHEN application_error THEN
        DBMS_OUTPUT.PUT_LINE('Números negativos são inválidos.');
    WHEN ZERO_DIVIDE THEN
        DBMS_OUTPUT.PUT_LINE('Erro: foi informado 0 membros para a família.');*/
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('O salário por membro da família é: '||sal_family_member(100,0));
END;
/