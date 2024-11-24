-- Tabela USUARIO
CREATE TABLE USUARIO (
ID_USUARIO NUMBER PRIMARY KEY,
NOME VARCHAR2(255) NOT NULL,
EMAIL VARCHAR2(255) UNIQUE NOT NULL,
DATA_NASCIMENTO DATE,
DATA_CADASTRO DATE DEFAULT SYSDATE NOT NULL
);
-- Tabela PLAYLIST
CREATE TABLE PLAYLIST (
ID_PLAYLIST NUMBER PRIMARY KEY,
NOME VARCHAR2(255) NOT NULL,
DESCRICAO VARCHAR2(4000),
DATA_CRIACAO DATE DEFAULT SYSDATE NOT NULL,
ID_USUARIO NUMBER NOT NULL,
FOREIGN KEY (ID_USUARIO) REFERENCES USUARIO(ID_USUARIO)
);
-- Tabela ARTISTA
CREATE TABLE ARTISTA (
ID_ARTISTA NUMBER PRIMARY KEY,
NOME VARCHAR2(255) NOT NULL
);
-- Tabela ALBUM
CREATE TABLE ALBUM (
ID_ALBUM NUMBER PRIMARY KEY,
NOME VARCHAR2(255) NOT NULL,
ANO_LANCAMENTO NUMBER,
ID_ARTISTA NUMBER NOT NULL,
FOREIGN KEY (ID_ARTISTA) REFERENCES ARTISTA(ID_ARTISTA)
);
-- Tabela MUSICA
CREATE TABLE MUSICA (
ID_MUSICA NUMBER PRIMARY KEY,
TITULO VARCHAR2(255) NOT NULL,
DURACAO NUMBER NOT NULL,
ANO_LANCAMENTO NUMBER,
ID_ALBUM NUMBER NOT NULL,
FOREIGN KEY (ID_ALBUM) REFERENCES ALBUM(ID_ALBUM)
);

-- Tabela GENERO_MUSICAL
CREATE TABLE GENERO_MUSICAL (
ID_GENERO NUMBER PRIMARY KEY,
NOME VARCHAR2(255) NOT NULL
);
-- Tabela PlaylistMusica
CREATE TABLE PlaylistMusica (
ID_PLAYLIST NUMBER NOT NULL,
ID_MUSICA NUMBER NOT NULL,
ORDEM NUMBER NOT NULL,
PRIMARY KEY (ID_PLAYLIST, ID_MUSICA),
FOREIGN KEY (ID_PLAYLIST) REFERENCES PLAYLIST(ID_PLAYLIST),
FOREIGN KEY (ID_MUSICA) REFERENCES MUSICA(ID_MUSICA)
);
-- Tabela MusicaGenero
CREATE TABLE MusicaGenero (
ID_MUSICA NUMBER NOT NULL,
ID_GENERO NUMBER NOT NULL,
PRIMARY KEY (ID_MUSICA, ID_GENERO),
FOREIGN KEY (ID_MUSICA) REFERENCES MUSICA(ID_MUSICA),
FOREIGN KEY (ID_GENERO) REFERENCES GENERO_MUSICAL(ID_GENERO)
);
-- Sequence para a tabela USUARIO
CREATE SEQUENCE SEQ_USUARIO
START WITH 1
INCREMENT BY 1;
-- Sequence para a tabela PLAYLIST
CREATE SEQUENCE SEQ_PLAYLIST
START WITH 1
INCREMENT BY 1;
-- Sequence para a tabela MUSICA
CREATE SEQUENCE SEQ_MUSICA
START WITH 1
INCREMENT BY 1;
-- Sequence para a tabela ALBUM
CREATE SEQUENCE SEQ_ALBUM
START WITH 1
INCREMENT BY 1;
-- Sequence para a tabela ARTISTA
CREATE SEQUENCE SEQ_ARTISTA
START WITH 1
INCREMENT BY 1;
-- Sequence para a tabela GENERO_MUSICAL
CREATE SEQUENCE SEQ_GENERO
START WITH 1
INCREMENT BY 1;