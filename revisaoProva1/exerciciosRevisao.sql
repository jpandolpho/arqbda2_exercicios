/*1. (Subconsulta - �nica linha) Liste o nome de todos os artistas que lan�aram �lbuns no
mesmo ano que o �lbum "Cor" da AnaVit�ria.*/
select nome
from artista
where id_artista in (
    select id_artista
    from album
    where ano_lancamento = (select ano_lancamento from album where nome='Cor')
);

/*2. (Subconsulta - M�ltiplas linhas) Liste o nome de todas as m�sicas que est�o na playlist
"MPB Favoritas".*/
select m.titulo
from musica m join playlistmusica pm on m.id_musica=pm.id_musica
    join playlist p on pm.id_playlist=p.id_playlist
where p.nome = 'MPB Favoritas';

/*3. (Subconsulta - Correlacionada) Liste o nome de todos os artistas que possuem mais de
um �lbum cadastrado.*/
select nome
from artista a
where (
    select count(*)
    from album
    where id_artista = a.id_artista
) > 1;

/*4. (INNER JOIN - USING) Liste o t�tulo da m�sica e o nome do g�nero musical de todas as
m�sicas que possuem g�nero cadastrado.*/
select titulo, nome
from musica inner join musicagenero using (id_musica)
    inner join genero_musical using (id_genero);
    
/*5. (INNER JOIN - ON) Liste o nome do artista e o nome do �lbum para todos os �lbuns
lan�ados.*/
select ar.nome, al.nome
from artista ar inner join album al on ar.id_artista=al.id_artista;

/*6. (LEFT JOIN) Liste o nome de todos os usu�rios e o nome das playlists que eles criaram,
incluindo usu�rios que n�o criaram playlists.*/
select u.nome, p.nome
from usuario u left join playlist p using (id_usuario);

/*7. (RIGHT JOIN) Liste o nome de todas as playlists e o nome do usu�rio que a criou,
incluindo playlists que n�o foram criadas por nenhum usu�rio (se houver).*/
select u.nome, p.nome
from usuario u right join playlist p using (id_usuario);

/*8. (FULL JOIN) Liste o nome de todos os usu�rios e o nome das playlists que eles criaram,
incluindo usu�rios que n�o criaram playlists e playlists que n�o foram criadas por nenhum
usu�rio (se houver).*/
select u.nome, p.nome
from usuario u full join playlist p using (id_usuario);

/*9. (AUTO JUN��O) Liste os pares de m�sicas que possuem o mesmo ano de lan�amento*/
select m1.titulo, m2.titulo
from musica m1, musica m2
where m1.ano_lancamento=m2.ano_lancamento and m1.id_musica<m2.id_musica;

/*10. (GROUP BY - ROLLUP) Liste a quantidade de m�sicas por g�nero musical, incluindo um
subtotal para cada g�nero e um total geral.*/
select nome, count(id_musica) as quantidade
from genero_musical join musicagenero using (id_genero)
group by rollup(nome);

/*11. (GROUP BY - CUBE) Liste a quantidade de m�sicas por g�nero musical e por ano de
lan�amento, incluindo subtotais e totais gerais.*/
select nome, ano_lancamento, count(id_musica) as quantidade
from genero_musical join musicagenero using(id_genero)
    join musica using (id_musica)
group by cube(nome, ano_lancamento);

/*12. (GROUP BY - GROUPING) Liste a quantidade de m�sicas por g�nero musical e por ano
de lan�amento, identificando as linhas de subtotal e total geral.*/
select nome, ano_lancamento, count(id_musica) quantidade,
    grouping(nome) as grp_genero,
    grouping(ano_lancamento) as grp_ano
from genero_musical join musicagenero using(id_genero)
    join musica using (id_musica)
group by cube(nome, ano_lancamento);

/*13. (GROUP BY - GROUPING SET) Liste a quantidade de m�sicas por g�nero musical, a
quantidade de m�sicas por ano de lan�amento e o total geral de m�sicas.*/
select nome, ano_lancamento, count(id_musica) as quantidade
from genero_musical join musicagenero using(id_genero)
    join musica using (id_musica)
group by grouping sets ((nome), (ano_lancamento),());

/*14. (INTERSECT) Liste as m�sicas que est�o presentes em todas as playlists.*/
select id_musica
from playlistmusica
where id_playlist=1
intersect
select id_musica
from playlistmusica
where id_playlist=2;

/*15. (MINUS) Liste as m�sicas que est�o na playlist "MPB Favoritas" mas n�o est�o na playlist
"Rock Internacional"*/
select titulo
from musica join playlistmusica using (id_musica)
    join playlist using (id_playlist)
where nome = 'MPB Favoritas'
minus
select titulo
from musica join playlistmusica using (id_musica)
    join playlist using (id_playlist)
where nome = 'Rock Internacional';

/*16. (UNION) Liste todos os nomes de artistas e usu�rios, sem repeti��es.*/
select nome from artista
union
select nome from usuario;

/*17. (UNION ALL) Liste todos os nomes de artistas e usu�rios, incluindo repeti��es.*/
select nome from artista
union all
select nome from usuario;

/*18. (TO_CHAR(null)) Liste o nome e a data de nascimento de todos os usu�rios, formatando a
data de nascimento como 'DD/MM/YYYY' e exibindo 'Sem data' caso a data de nascimento
seja nula.*/
select nome, to_char(data_nascimento, 'DD/MM/YYYY') as data_nascimento_formatada
from usuario;

/*19. (Igualando a lista SELECT) Liste o nome das m�sicas que t�m a mesma dura��o que a
m�sica "Amarelo, Azul e Branco".*/
select titulo
from musica
where duracao = (
    select duracao
    from musica
    where titulo = 'Amarelo, Azul e Branco'
);

/*20. (Subconsulta - WHERE � GROUP BY � HAVING) Liste o nome dos artistas que possuem
mais �lbuns lan�ados do que o artista "Imagine Dragons".*/
select ar.nome
from artista ar join album al using (id_artista)
group by ar.nome
having count(id_album) > (
    select count(al2.id_album)
    from album al2 join artista ar2 using (id_artista)
    where ar2.nome = 'Imagine Dragons'
    group by ar2.nome
);    