create database trabBD;
use trabBD;



create table usuario(
	IDusuario int primary key auto_increment,
    nome varchar(100),
    nome_de_usuario varchar(100) not null,
    senha varchar(100) not null,
    status_user varchar(100) not null,
    email varchar(255) not null,
    imagem_user blob
);

create table administrador(
	IDadministrador int primary key auto_increment not null,
    nome varchar(100),
    senha varchar(100) not null,
    status_adm boolean not null,
	email varchar(255) not null,
    cpf varchar(20) not null,
    data_contratacao date not null,
    imagem_user blob not null
);

create table jogo(
	IDjogo int primary key auto_increment,
    nome_jogo varchar(100),
    desenvolvedora varchar(100),
    classificacao_indicativa int,
    categoria varchar(100),
    capa_jogo blob,
    sinopse varchar(255),
    data_lancamento date,
    number_user int,
    IDadministrador int,
	FOREIGN KEY (IDadministrador) REFERENCES trabBD.administrador(IDadministrador)
    /*endereço jogo
    */
);

create table Biblioteca(
	nome_no_jogo varchar(100),
    id_jogo int,
    id_usuario int,
    FOREIGN KEY (id_jogo) REFERENCES trabBD.jogo(IDjogo),
    FOREIGN KEY (id_usuario) REFERENCES trabBD.usuario(IDusuario)
);

create table conquistas(
	idconquista int primary key auto_increment,
    nome_conquista varchar(100),
    data_obtencao date,
    IDusuario int,
    FOREIGN KEY (IDusuario) REFERENCES trabBD.usuario(IDusuario)
);

create table enderecoJogo(
	launcherorigem varchar(255),
    caminhojogo varchar(255)
);

create table historicoPartida(
id_Part int primary key,
hora_inicio datetime,
hora_fim datetime,
id_user int,
status_result varchar(20),
FOREIGN KEY (id_user) REFERENCES trabBD.usuario(IDusuario)
);

create table personagem(
id_perso int primary key auto_increment,
nome_perso varchar(20),
id_jogo int,
FOREIGN KEY (id_jogo) REFERENCES trabBD.jogo(IDjogo)
);

create table informacoesDeTemporada(
id_temp int primary key auto_increment,
data_init date,
data_end date
);

create table rankingGeral(
id_temp int primary key auto_increment,
data_init date
);
