/*1. (Subconsulta - Única linha) Liste o nome de todos os artistas que lançaram álbuns no
mesmo ano que o álbum "Cor" da AnaVitória.*/
select nome
from artista
where id_artista in (
    select id_artista
    from album
    where ano_lancamento = (select ano_lancamento from album where nome='Cor')
);

/*2. (Subconsulta - Múltiplas linhas) Liste o nome de todas as músicas que estão na playlist
"MPB Favoritas".*/
select m.titulo
from musica m join playlistmusica pm on m.id_musica=pm.id_musica
    join playlist p on pm.id_playlist=p.id_playlist
where p.nome = 'MPB Favoritas';

/*3. (Subconsulta - Correlacionada) Liste o nome de todos os artistas que possuem mais de
um álbum cadastrado.*/
select nome
from artista a
where (
    select count(*)
    from album
    where id_artista = a.id_artista
) > 1;

/*4. (INNER JOIN - USING) Liste o título da música e o nome do gênero musical de todas as
músicas que possuem gênero cadastrado.*/
select titulo, nome
from musica inner join musicagenero using (id_musica)
    inner join genero_musical using (id_genero);
    
/*5. (INNER JOIN - ON) Liste o nome do artista e o nome do álbum para todos os álbuns
lançados.*/
select ar.nome, al.nome
from artista ar inner join album al on ar.id_artista=al.id_artista;

/*6. (LEFT JOIN) Liste o nome de todos os usuários e o nome das playlists que eles criaram,
incluindo usuários que não criaram playlists.*/
select u.nome, p.nome
from usuario u left join playlist p using (id_usuario);

/*7. (RIGHT JOIN) Liste o nome de todas as playlists e o nome do usuário que a criou,
incluindo playlists que não foram criadas por nenhum usuário (se houver).*/
select u.nome, p.nome
from usuario u right join playlist p using (id_usuario);

/*8. (FULL JOIN) Liste o nome de todos os usuários e o nome das playlists que eles criaram,
incluindo usuários que não criaram playlists e playlists que não foram criadas por nenhum
usuário (se houver).*/
select u.nome, p.nome
from usuario u full join playlist p using (id_usuario);

/*9. (AUTO JUNÇÃO) Liste os pares de músicas que possuem o mesmo ano de lançamento*/
select m1.titulo, m2.titulo
from musica m1, musica m2
where m1.ano_lancamento=m2.ano_lancamento and m1.id_musica<m2.id_musica;

/*10. (GROUP BY - ROLLUP) Liste a quantidade de músicas por gênero musical, incluindo um
subtotal para cada gênero e um total geral.*/
select nome, count(id_musica) as quantidade
from genero_musical join musicagenero using (id_genero)
group by rollup(nome);

/*11. (GROUP BY - CUBE) Liste a quantidade de músicas por gênero musical e por ano de
lançamento, incluindo subtotais e totais gerais.*/
select nome, ano_lancamento, count(id_musica) as quantidade
from genero_musical join musicagenero using(id_genero)
    join musica using (id_musica)
group by cube(nome, ano_lancamento);

/*12. (GROUP BY - GROUPING) Liste a quantidade de músicas por gênero musical e por ano
de lançamento, identificando as linhas de subtotal e total geral.*/
select nome, ano_lancamento, count(id_musica) quantidade,
    grouping(nome) as grp_genero,
    grouping(ano_lancamento) as grp_ano
from genero_musical join musicagenero using(id_genero)
    join musica using (id_musica)
group by cube(nome, ano_lancamento);

/*13. (GROUP BY - GROUPING SET) Liste a quantidade de músicas por gênero musical, a
quantidade de músicas por ano de lançamento e o total geral de músicas.*/
select nome, ano_lancamento, count(id_musica) as quantidade
from genero_musical join musicagenero using(id_genero)
    join musica using (id_musica)
group by grouping sets ((nome), (ano_lancamento),());

/*14. (INTERSECT) Liste as músicas que estão presentes em todas as playlists.*/
select id_musica
from playlistmusica
where id_playlist=1
intersect
select id_musica
from playlistmusica
where id_playlist=2;

/*15. (MINUS) Liste as músicas que estão na playlist "MPB Favoritas" mas não estão na playlist
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

/*16. (UNION) Liste todos os nomes de artistas e usuários, sem repetições.*/
select nome from artista
union
select nome from usuario;

/*17. (UNION ALL) Liste todos os nomes de artistas e usuários, incluindo repetições.*/
select nome from artista
union all
select nome from usuario;

/*18. (TO_CHAR(null)) Liste o nome e a data de nascimento de todos os usuários, formatando a
data de nascimento como 'DD/MM/YYYY' e exibindo 'Sem data' caso a data de nascimento
seja nula.*/
select nome, to_char(data_nascimento, 'DD/MM/YYYY') as data_nascimento_formatada
from usuario;

/*19. (Igualando a lista SELECT) Liste o nome das músicas que têm a mesma duração que a
música "Amarelo, Azul e Branco".*/
select titulo
from musica
where duracao = (
    select duracao
    from musica
    where titulo = 'Amarelo, Azul e Branco'
);

/*20. (Subconsulta - WHERE – GROUP BY – HAVING) Liste o nome dos artistas que possuem
mais álbuns lançados do que o artista "Imagine Dragons".*/
select ar.nome
from artista ar join album al using (id_artista)
group by ar.nome
having count(id_album) > (
    select count(al2.id_album)
    from album al2 join artista ar2 using (id_artista)
    where ar2.nome = 'Imagine Dragons'
    group by ar2.nome
);    