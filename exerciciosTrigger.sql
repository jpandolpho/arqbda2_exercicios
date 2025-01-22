/*Exercício 1: Validação de Salário
Crie um trigger na tabela EMPLOYEES que previna a inserção de um salário menor
que o salário mínimo definido para o cargo do funcionário na tabela JOBS.*/

CREATE OR REPLACE TRIGGER insert_employee_min_salary
    BEFORE INSERT ON employees FOR EACH ROW
DECLARE
    v_min_sal jobs.min_salary%TYPE;
    v_job_id employees.job_id%TYPE;
    v_salary employees.salary%TYPE;
BEGIN
    v_job_id := :NEW.job_id;
    v_salary := :NEW.salary;
    SELECT min_salary INTO v_min_sal
        FROM jobs
        WHERE job_id = v_job_id;
    IF v_salary < v_min_sal THEN
        RAISE_APPLICATION_ERROR(-20501, 'Salário menor do que o mínimo do cargo.');
    END IF;
END;
/

INSERT INTO employees(employee_id,last_name,email,hire_date,job_id,salary) VALUES (EMPLOYEES_SEQ.nextval,'Andolpho','ANDOLPHO',TO_DATE('2024-11-27','YYYY-MM-DD'),'IT_PROG',3900);

/*Exercício 2: Cálculo de Remuneração Total
Crie um trigger na tabela EMPLOYEES que calcule a remuneração total (salário +
comissão) e armazene o resultado em uma nova coluna TOTAL_PAY sempre que o
salary ou commission_pct forem atualizados.*/

SAVEPOINT sp1;

ALTER TABLE employees
    ADD total_pay NUMBER(8,2);
    
CREATE OR REPLACE TRIGGER alter_total_pay
    BEFORE UPDATE OF salary, commission_pct ON employees FOR EACH ROW
DECLARE
    v_total_pay employees.total_pay%TYPE;
    v_commision employees.commission_pct%TYPE;
BEGIN
    v_commision := :NEW.commission_pct;
    IF v_commision IS NULL THEN
        v_commision := 0;
    END IF;
    :NEW.total_pay := :NEW.salary + (:NEW.salary*v_commision);
END;
/

UPDATE employees
    SET salary = 5050
    where employee_id = 103;
    
ROLLBACK sp1;

/*Exercício 3: Auditoria de Alterações
Crie um trigger na tabela EMPLOYEES para registrar as modificações realizadas nos
dados dos funcionários. O trigger deve inserir um registro em uma nova tabela
EMPLOYEE_AUDIT sempre que um funcionário for inserido, atualizado ou excluído.*/
SAVEPOINT sp2;

CREATE TABLE EMPLOYEE_AUDIT (
    user_id	VARCHAR2(30),   
    logon_date	 DATE 
);

CREATE OR REPLACE TRIGGER log_employees_changes 
    AFTER INSERT OR UPDATE OR DELETE ON employees   
    BEGIN 
        INSERT INTO employee_audit VALUES (USER, SYSDATE); 
END; 
/

UPDATE employees
    SET salary = 5050
    where employee_id = 103;
    
ROLLBACK sp2;

/*Exercício 4: Controle de Estoque (Adaptado)
Crie um trigger na tabela JOB_HISTORY que, ao inserir um novo registro, verifique se
o funcionário está mudando de departamento. Caso positivo, insira um registro em uma
nova tabela DEPARTAMENTO_TRANSFERENCIA com o employee_id, o
department_id antigo e o novo.*/
SAVEPOINT sp3;

CREATE TABLE departamento_transferencia (
    employee_id NUMBER(6,0),
    old_department NUMBER(4,0),
    new_department NUMBER(4,0)
);

CREATE OR REPLACE TRIGGER alter_employee_department
    AFTER UPDATE OF department_id ON employees FOR EACH ROW
BEGIN
    INSERT INTO departamento_transferencia VALUES (:NEW.employee_id, :OLD.department_id, :NEW.department_id);
END;
/

UPDATE employees
    SET department_id = 10
    where employee_id = 103;

ROLLBACK sp3;

/*Exercício 5: Exclusão em Cascata (Adaptado)
Crie um trigger na tabela COUNTRIES que, ao excluir um país, exclua também as
localidades (LOCATIONS) associadas a ele.*/

SAVEPOINT sp4;

CREATE OR REPLACE TRIGGER delete_cascade
    BEFORE DELETE ON countries FOR EACH ROW
BEGIN
    DELETE FROM locations WHERE country_id=:OLD.country_id;
END;

DELETE FROM countries WHERE country_id='BR';

ROLLBACK sp4;