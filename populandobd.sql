insert into usuario (nome,user,senha,status_user,email) values("Daniel","@niel","senhaforte","Online","daniel@eu");
insert into usuario (nome,user,senha,status_user,email) values("teste","@opa","senhaforte","Online","teste@eu");
insert into usuario (nome,user,senha,status_user,email) values("outro","@other","senhaforte","Online","iai@eu");
insert into usuario (nome,user,senha,status_user,email) values("dan","@dan","dan","Online","dan@eu");
insert into usuario (nome,user,senha,status_user,email) values("bob","@cleiton","dog","Online","dog@auau");

insert into administrador(nome,senha,email,cpf,data_contratacao) values ("eu","eu","eu@adm","11122233300","2001-04-13 08:04:02");
insert into administrador(nome,senha,email,cpf,data_contratacao) values ("admin","admin","admin@adm","00000000000","2001-04-13 08:04:02");
insert into administrador(nome,senha,email,cpf,data_contratacao) values ("danieladm","senhaforte","daniel@adm","000.111.222-33","2001-04-13 08:04:02");
insert into administrador(nome,senha,email,cpf,data_contratacao) values ("gabsadm","senhaforte","gabs@adm","000.111.222-33","2001-04-13 08:04:02");
insert into administrador(nome,senha,email,cpf,data_contratacao) values ("euadm","senhaforte","eu@adm","000.111.222-33","2001-04-13 08:04:02");
insert into administrador(nome,senha,email,cpf,data_contratacao) values ("tuadm","senhaforte","tu@adm","000.111.222-33","2001-04-13 08:04:02");
insert into administrador(nome,senha,email,cpf,data_contratacao) values ("maisadm","senhaforte","plus@adm","000.111.222-33","2001-04-13 08:04:02");

insert into jogo(nome_jogo,desenvolvedora,classificacao_indicativa,categoria,sinopse,data_lancamento,number_user,IDadministrador) values ("fort","epic","16","nao sei","pei pei pou pou","2015-01-01","5","1");
insert into jogo(nome_jogo,desenvolvedora,classificacao_indicativa,categoria,sinopse,data_lancamento,number_user,IDadministrador) values ("lolzin","riot","16","nao sei","pei pei pou pou","2015-01-01","5","2");
insert into jogo(nome_jogo,desenvolvedora,classificacao_indicativa,categoria,sinopse,data_lancamento,number_user,IDadministrador) values ("mario","nintendo","16","nao sei","pei pei pou pou","2015-01-01","5","1");
insert into jogo(nome_jogo,desenvolvedora,classificacao_indicativa,categoria,sinopse,data_lancamento,number_user,IDadministrador) values ("zelda","nitendo","16","nao sei","pei pei pou pou","2015-01-01","5","2");
insert into jogo(nome_jogo,desenvolvedora,classificacao_indicativa,categoria,sinopse,data_lancamento,number_user,IDadministrador) values ("fifa","ea","16","nao sei","pei pei pou pou","2015-01-01","5","3");

insert into Biblioteca(nome_no_jogo,id_jogo,id_usuario) values ("@dan.eu","1","1");
insert into Biblioteca(nome_no_jogo,id_jogo,id_usuario) values ("@dan.eu","2","1");
insert into Biblioteca(nome_no_jogo,id_jogo,id_usuario) values ("@dan.eu","3","1");
insert into Biblioteca(nome_no_jogo,id_jogo,id_usuario) values ("@dan.eu","4","1");
insert into Biblioteca(nome_no_jogo,id_jogo,id_usuario) values ("@dan.eu","5","1");

insert into Biblioteca(nome_no_jogo,id_jogo,id_usuario) values ("@teste","1","2");
insert into Biblioteca(nome_no_jogo,id_jogo,id_usuario) values ("@teste","2","2");
insert into Biblioteca(nome_no_jogo,id_jogo,id_usuario) values ("@teste","3","2");
insert into Biblioteca(nome_no_jogo,id_jogo,id_usuario) values ("@teste","4","2");
insert into Biblioteca(nome_no_jogo,id_jogo,id_usuario) values ("@teste","5","2");

insert into Biblioteca(nome_no_jogo,id_jogo,id_usuario) values ("@gabs","1","3");
insert into Biblioteca(nome_no_jogo,id_jogo,id_usuario) values ("@gabs","2","3");
insert into Biblioteca(nome_no_jogo,id_jogo,id_usuario) values ("@gabs","3","3");
insert into Biblioteca(nome_no_jogo,id_jogo,id_usuario) values ("@gabs","4","3");
insert into Biblioteca(nome_no_jogo,id_jogo,id_usuario) values ("@gabs","5","3");

insert into historicoPartida(id_Part,hora_inicio,hora_fim,id_user,status_result,IDjogo,pontos) values ("0001","2021-09-01 20:20:20","2021-09-01 20:30:20","1","fim","1","9");
insert into historicoPartida(id_Part,hora_inicio,hora_fim,id_user,status_result,IDjogo,pontos) values ("0001","2021-09-01 20:20:20","2021-09-01 20:30:20","2","fim","1","10");

insert into historicoPartida(id_Part,hora_inicio,hora_fim,id_user,status_result,IDjogo,pontos) values ("0002","2020-09-01 20:20:20","2020-09-01 20:30:20","1","fim","2","9");
insert into historicoPartida(id_Part,hora_inicio,hora_fim,id_user,status_result,IDjogo,pontos) values ("0002","2020-09-01 20:20:20","2020-09-01 20:30:20","3","fim","2","10");

insert into jogo(nome_jogo,desenvolvedora,classificacao_indicativa,categoria,sinopse,data_lancamento,IDadministrador) values ('teste','teste','2','teste','teste','2021-10-30','1');

call conquista("Teste campeao","1","1","1");
select * from conquistas;

select * from historicoPartida;
select * from administrador;
select * from jogo;
select * from usuario;
select * from Biblioteca;
select * from historicoPartida;
select * from vw_partidasuser;
select * from vw_infogames;