SET SERVEROUT ON;
/*1. Inserir um novo departamento chamado 'Research' com ID 280 e localizado
em 'Seattle'.
○ Utilize um bloco anônimo com a instrução INSERT para inserir o novo
departamento na tabela DEPARTMENTS.*/
declare
    v_depto varchar(20):= 'Research';
    v_idDep int :=280;
    v_cidade int;
begin
    select location_id
    into v_cidade
    from locations
    where city like 'Seattle';
    
    insert into departments(department_id, department_name, location_id)
    values (v_idDep, v_depto, v_cidade);
end;

/*2. Criar uma nova localização em 'São Paulo' com ID 3300.
○ Utilize um bloco anônimo com a instrução INSERT e a sequência
LOCATIONS_SEQ para inserir a nova localização na tabela LOCATIONS*/
declare
    v_cidade varchar(20):='São Paulo';
    v_id int:=LOCATIONS_SEQ.nextval;
begin
    insert into locations(city,location_id)
    values (v_cidade,v_id);
end;

/*3. Remover o departamento 'Shipping'.
○ Utilize um bloco anônimo com a instrução DELETE para remover o departamento
'Shipping' da tabela DEPARTMENTS.*/
begin
    delete from departments
    where department_name='Shipping';
end;

/*4. Atualizar o nome do cargo 'Programmer' para 'Software Engineer'.
○ Utilize um bloco anônimo com a instrução UPDATE para atualizar o nome do cargo
na tabela JOBS.*/
declare
    v_cargo varchar(30) := 'Software Engineer';
begin
    update jobs
    set job_title=v_cargo
    where job_title='Programmer';
end;

/*5. Encontrar o salário mais alto, o salário mais baixo e a diferença entre eles.
○ Utilize um bloco anônimo com as funções MAX e MIN para encontrar o salário mais
alto e o mais baixo na tabela EMPLOYEES e calcular a diferença entre eles.*/
declare
    v_max number(8,2);
    v_min number(8,2);
    v_dif number(8,2);
begin
    select max(salary) into v_max
    from employees;
    dbms_output.put_line('Max: ' || TO_CHAR(v_max));
    
    select min(salary) into v_min
    from employees;
    dbms_output.put_line('Min: ' || TO_CHAR(v_min));
    
    dbms_output.put_line('Diff: ' || TO_CHAR(v_max-v_min));
end;

/*6. Inserir um novo funcionário na tabela EMPLOYEES.
○ Utilize um bloco anônimo com a instrução INSERT e a sequência
EMPLOYEES_SEQ para inserir um novo funcionário na tabela EMPLOYEES.*/
declare
    v_job_id  VARCHAR2(10);
    v_next NUMBER(6,0):= EMPLOYEES_SEQ.nextval;
begin
    select job_id into v_job_id
    from jobs
    where job_title='Software Engineer';
    
    insert into employees(employee_id,hire_date,job_id, first_name, last_name, email)
    values (v_next, sysdate, v_job_id,'João', 'Andolpho', 'JANDOLPHO');
end;

/*7. Atualizar o salário de um funcionário com base no seu ID.
○ Utilize um bloco anônimo com a instrução UPDATE para atualizar o salário de um
funcionário na tabela EMPLOYEES com base no seu ID.*/
declare
    v_idFunc number(6,0);
begin
    select employee_id into v_idFunc
    from employees
    where last_name like 'Chen';
    
    update employees
    set salary = salary*1.15
    where employee_id = v_idFunc;
end;

/*8. Remover um funcionário da tabela EMPLOYEES com base no seu ID.
○ Utilize um bloco anônimo com a instrução DELETE para remover um funcionário
da tabela EMPLOYEES com base no seu ID.*/
declare
    v_idFunc number(6,0);
begin
    select employee_id into v_idFunc
    from employees
    where last_name like 'Andolpho';
    
    delete from employees
    where employee_id = v_idFunc;
end;