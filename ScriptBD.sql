create database trabBD;
use trabBD;

create table administrador(
    IDadministrador int primary key auto_increment not null,
    nome varchar(100),
    user varchar(100) ,
    senha varchar(100),
    status_adm boolean,
    email varchar(255),
    chave varchar(100),
    cpf varchar(20),
    data_contratacao date,
    imagem_user blob
);
create table usuario(
    IDusuario int primary key auto_increment,
    nome varchar(100),
    user varchar(100) not null,
    senha varchar(100) not null,
    status_user varchar(100),
    email varchar(255),
    imagem_user blob
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
id_Part int,
hora_inicio datetime,
hora_fim datetime,
id_user int,
pontos int,
status_result varchar(20),
FOREIGN KEY (id_user) REFERENCES trabBD.usuario(IDusuario),

IDjogo int,
FOREIGN KEY (IDjogo) REFERENCES trabBD.Biblioteca(id_jogo)
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

create table seguir(
	inicioseguir datetime,
    quemsegue int,
    seguido int,
    
    FOREIGN KEY (quemsegue) REFERENCES trabBD.usuario(IDusuario),
    FOREIGN KEY (seguido) REFERENCES trabBD.usuario(IDusuario)
);

/*Tabela com jogos cadastrados por determinado ADM*/
create view vw_infogames
AS Select 
	jogo.IDjogo as idjogo, 
	jogo.nome_jogo as nomejogo,jogo.desenvolvedora as nomedesencolvedora,
    jogo.classificacao_indicativa as classificacaoindicativa,
    jogo.categoria as genero,
    jogo.capa_jogo as capa,
    jogo.sinopse as sinopse,
    jogo.data_lancamento as lancamento,
    administrador.IDadministrador as idadm,
    administrador.nome as nomeadm
from jogo,administrador
where administrador.IDadministrador = jogo.IDadministrador
order by nomeadm;

/*todas as partidas de cada usuario*/
create view vw_partidasuser
AS Select 
	usuario.IDusuario as iduser,
    usuario.nome as nomeCompleto,
    usuario.user as nomePlataforma,
    usuario.imagem_user as icone,
    
    historicoPartida.id_Part as idpartida,
	historicoPartida.hora_inicio as horainicio,
	historicoPartida.hora_fim as horafim,
    historicoPartida.IDjogo as idjogo,
    
    Biblioteca.nome_no_jogo as nomeuserjogo
    
from usuario,historicoPartida,Biblioteca
where usuario.IDusuario = historicoPartida.id_user and usuario.IDusuario = Biblioteca.id_usuario and historicoPartida.IDjogo = Biblioteca.id_jogo and historicoPartida.id_user = Biblioteca.id_usuario
order by horainicio,nomePlataforma;

delimiter $$
create procedure conquista(in nomeConquista varchar(100), in IDusuario int, in pontosmax int, in idJogo int)
begin
	set @total_pontos = 0;
	select sum(historicoPartida.pontos) INTO @total_pontos
    from historicoPartida 
    where historicoPartida.id_user = IDusuario and historicoPartida.IDjogo = idJogo;

    IF @total_pontos >= pontosmax then
		insert into conquistas(nome_conquista,data_obtencao,IDusuario) values (nomeConquista,curdate(),IDusuario);
	end if;
end $$
delimiter ;
