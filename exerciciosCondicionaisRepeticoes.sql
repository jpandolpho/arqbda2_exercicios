SET SERVEROUT ON;

/*1. Crie um bloco anônimo que exiba a mensagem "Olá, mundo!".*/
BEGIN
    DBMS_OUTPUT.PUT_LINE('Olá, mundo!');
END;

/*2. Crie um bloco anônimo que declare uma variável do tipo NUMBER e atribua o valor 10 a
ela. Exiba o valor da variável.*/
DECLARE
    v_number NUMBER := 10;
BEGIN
    DBMS_OUTPUT.PUT_LINE(v_number);
END;

/*3. Crie um bloco anônimo que declare duas variáveis do tipo NUMBER, atribua valores a
elas e exiba a soma das variáveis*/
DECLARE
    v_x NUMBER:=7;
    v_y NUMBER:=6;
BEGIN
    DBMS_OUTPUT.PUT_LINE(v_x+v_y);
END;

/*4. Crie um bloco anônimo que declare uma variável do tipo VARCHAR2 e atribua o seu
nome a ela. Exiba o valor da variável.*/
DECLARE
    v_nome VARCHAR2(20):= 'João Andolpho';
BEGIN
    DBMS_OUTPUT.PUT_LINE(TO_CHAR(v_nome));
END;

/*5. Crie um bloco anônimo que declare uma variável do tipo DATE e atribua a data atual a
ela. Exiba o valor da variável*/
DECLARE
    v_data DATE := SYSDATE;
BEGIN
    DBMS_OUTPUT.PUT_LINE(v_data);
END;

/*6. Crie um bloco anônimo que use uma instrução IF para verificar se um número é positivo.
Se for, exiba a mensagem "O número é positivo".*/
DECLARE
    v_number NUMBER:= 7;
BEGIN
    IF v_number > 0 THEN
        DBMS_OUTPUT.PUT_LINE('O número é positivo');
    END IF;
END;

/*7. Crie um bloco anônimo que use uma instrução IF para verificar se um número é par. Se
for, exiba a mensagem "O número é par".*/
DECLARE
    v_number NUMBER:= 7;
BEGIN
    IF v_number MOD 2 = 0 THEN
        DBMS_OUTPUT.PUT_LINE('O número é par');
    END IF;
END;

/*8. Crie um bloco anônimo que use uma instrução IF para verificar se uma string é igual a
"SIM". Se for, exiba a mensagem "A string é igual a SIM".*/
DECLARE
    v_str VARCHAR2(10) := 'SIM';
BEGIN
    IF v_str = 'SIM' THEN
        DBMS_OUTPUT.PUT_LINE('A string é igual a SIM');
    END IF;
END;

/*9. Crie um bloco anônimo que use uma instrução IF para verificar se uma data é anterior à
data atual. Se for, exiba a mensagem "A data é anterior à data atual".*/
DECLARE
    v_data DATE := TO_DATE('2024-12-11','YYYY-MM-DD');
BEGIN
    IF v_data < sysdate THEN
        DBMS_OUTPUT.PUT_LINE('A data é anterior à data atual');
    END IF;
END;

/*10. Crie um bloco anônimo que use uma instrução CASE para verificar o valor de uma
variável e exibir uma mensagem diferente para cada valor.*/
DECLARE
    v_number NUMBER :=6;
BEGIN
    CASE v_number 
        WHEN 7 THEN DBMS_OUTPUT.PUT_LINE('Numero 7');
        WHEN 8 THEN DBMS_OUTPUT.PUT_LINE('Numero 8');
        WHEN 9 THEN DBMS_OUTPUT.PUT_LINE('Numero 9');
        WHEN 10 THEN DBMS_OUTPUT.PUT_LINE('Numero 10');
        ELSE DBMS_OUTPUT.PUT_LINE('Other number');
    END CASE;
END;

/*11. Crie um bloco anônimo que use uma instrução CASE para verificar se um número é
positivo, negativo ou zero*/
DECLARE
    v_number NUMBER :=0;
    v_str VARCHAR2(20);
BEGIN
    v_str:= CASE
        WHEN v_number > 0 THEN 'Positivo'
        WHEN v_number < 0 THEN 'Negativo'
        ELSE 'Zero'
    END;
    DBMS_OUTPUT.PUT_LINE(v_str);
END;

/*12. Crie um bloco anônimo que use uma instrução CASE para verificar se uma string é igual
a "A", "B" ou "C".*/
DECLARE
    v_str VARCHAR(1):='D';
BEGIN
    CASE v_str
        WHEN 'A' THEN DBMS_OUTPUT.PUT_LINE('A');
        WHEN 'B' THEN DBMS_OUTPUT.PUT_LINE('B');
        WHEN 'C' THEN DBMS_OUTPUT.PUT_LINE('C');
        ELSE DBMS_OUTPUT.PUT_LINE('Other');
    END CASE;
END;

/*13. Crie um bloco anônimo que use uma instrução CASE para verificar se uma data é um dia
da semana, um fim de semana ou um feriado*/

/*14. Crie um bloco anônimo que use um loop simples para exibir os números de 1 a 10.*/
DECLARE
    v_counter NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(v_counter);   
        v_counter := v_counter + 1; 
        EXIT WHEN v_counter > 10;   
    END LOOP; 
END;

/*15. Crie um bloco anônimo que use um loop simples para exibir os números pares de 1 a 20.*/
DECLARE
    v_counter NUMBER := 1;
BEGIN
    LOOP
        IF v_counter mod 2 = 0 THEN
            DBMS_OUTPUT.PUT_LINE(v_counter);
        END IF;
        v_counter := v_counter + 1; 
        EXIT WHEN v_counter > 20;   
    END LOOP; 
END;

/*16. Crie um bloco anônimo que use um loop simples para exibir as letras do alfabeto.*/
DECLARE
    v_counter NUMBER := 65;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(CHR(v_counter));   
        v_counter := v_counter + 1; 
        EXIT WHEN v_counter > 90;   
    END LOOP; 
END;

/*17. Crie um bloco anônimo que use um loop simples para exibir os nomes dos meses do
ano*/
DECLARE
    v_counter NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(TO_CHAR(TO_DATE(v_counter,'MM'),'Month'));
        v_counter := v_counter + 1;
        EXIT WHEN v_counter > 12;
    END LOOP;
END;

/*18. Crie um bloco anônimo que use um loop WHILE para exibir os números de 1 a 10.*/
DECLARE
    v_counter NUMBER := 1;
BEGIN
    WHILE v_counter < 11 LOOP
        DBMS_OUTPUT.PUT_LINE(v_counter);
        v_counter := v_counter + 1;
    END LOOP;
END;

/*19. Crie um bloco anônimo que use um loop WHILE para exibir os números ímpares de 1 a
20.*/
DECLARE
    v_counter NUMBER := 1;
BEGIN
    WHILE v_counter < 21 LOOP
        IF v_counter mod 2 = 1 THEN
            DBMS_OUTPUT.PUT_LINE(v_counter);
        END IF;
        v_counter := v_counter + 1;
    END LOOP; 
END;

/*20. Crie um bloco anônimo que use um loop WHILE para exibir as letras do alfabeto em
ordem inversa*/
DECLARE
    v_counter NUMBER := 90;
BEGIN
    WHILE v_counter > 64 LOOP
        DBMS_OUTPUT.PUT_LINE(CHR(v_counter));   
        v_counter := v_counter - 1;
    END LOOP; 
END;

/*21. Crie um bloco anônimo que use um loop WHILE para exibir os nomes dos meses do ano
em ordem inversa.*/
DECLARE
    v_counter NUMBER := 12;
BEGIN
    WHILE v_counter >= 1 LOOP
        DBMS_OUTPUT.PUT_LINE(TO_CHAR(TO_DATE(v_counter,'MM'),'Month'));
        v_counter := v_counter - 1;
    END LOOP;
END;

/*22. Crie um bloco anônimo que use um loop FOR para exibir os números de 1 a 10.*/
BEGIN
    FOR i IN 1..10 LOOP
        DBMS_OUTPUT.PUT_LINE(i);
    END LOOP;
END;

/*23. Crie um bloco anônimo que use um loop FOR para exibir os números pares de 1 a 20*/
BEGIN
    FOR i IN 1..20 LOOP
        IF i mod 2 = 0 THEN
            DBMS_OUTPUT.PUT_LINE(i);
        END IF;
    END LOOP; 
END;

/*24. Crie um bloco anônimo que use um loop FOR para exibir as letras do alfabeto*/
BEGIN
    FOR i in 65..90 LOOP
        DBMS_OUTPUT.PUT_LINE(CHR(i));
    END LOOP; 
END;

/*25. Crie um bloco anônimo que use um loop FOR para exibir os nomes dos meses do ano.*/
BEGIN
    FOR i IN 1..12 LOOP
        DBMS_OUTPUT.PUT_LINE(TO_CHAR(TO_DATE(i,'MM'),'Month'));
    END LOOP;
END;