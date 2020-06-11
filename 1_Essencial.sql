/* REVISAO - To voltando 2020 */

/* Atalho para selecionar 1 linha Ctrl+Enter */
/* Atalho para selecionar linhas selecionadas Ctrl+Shift+Enter  */

/* DataBase */
create database comandos_sql; /* Cria banco */
drop database NOMEDB; /* Exclui banco */
use comandos_sql; /* Usa o banco */

select * from NOMETABELA; /* Seleciona os dados da tabela. O " * " significa 'all' */
drop table NOMETABELA; /* Exclui os dados da tabela */

/* Table */
/* CREATE */
create table aluno( /* Cria e Insere (abaixo) itens (colunas) na tabela */
	nome varchar(25),
    cpf varchar(11),
    idade int,
    telefone varchar(11)
);

/* INSERT INTO */
insert into aluno(nome,cpf,idade,telefone) value('Fulano',42366899813,17,'1126544358'); /* Insere dados (linhas) nas tabelas */
insert into aluno(nome,cpf,idade,telefone) value('Beltrano',42366899823,23,'1226544358');
insert into aluno(nome,cpf,idade,telefone) value('Sicrano',42366899833,33,'1326544358');
insert into aluno(nome,cpf,idade,telefone) value('Siclano',42366899843,57,'1426544358');

/* INSERT INTO + SELECT */
/* Podemos copiar dados de outra tabela utilizando esses 2 caras ai */
/* Como podemos ver eu copio da tabela aluno e colo na tabela endereco só os campos que eu quero */
/* Se voce nao estiver entendendo o porque do fk_idaluno estar alinhado com o idaluno, fique tranquilo
voce vai entender no arquivo 2 desse "tutorial" */
insert into endereco(logradouro, numero, complemento, fk_idaluno, bairro, cidade, estado)  
select logradouro, numero, complemento, idaluno, bairro, cidade, estado 
from aluno;

/* SELECT */
select * from aluno;
select nome,cpf from aluno; /* Selecionando mais de 1 coluna especifica */
select nome,cpf from aluno where nome = 'Fulano'; /* Selecinando mais de uma linha especifica e filtrando pelo nome */
select nome,telefone from aluno where idade = 17;

/* Operadores logicos */
/* vale lembrar que podemos usar os comparadores =,>,<,>=,<= e operadores logicos AND e OR */
select nome from aluno where nome = 'Fulano' OR nome = 'Siclano';

/* BETWEEN */
select nome, idade from aluno where idade between 20 AND 35; /* between = entre (entre esses 2 valores) */

/* IN , NOT IN */
select nome, idade from aluno where nome in('Fulano','Siclano');  /* O 'IN' quer dizer 'Trazer todos que contenha X ou Y' na tabela */
select nome from aluno where nome not in('Fulano','Beltrano'); /* O 'NOT IN' quer dizer que 'Não trazer todos que contenha X ou Y' na tabela */
/* Essa parte de cima é igual essa parte de baixo, so que escrito de modo mais resumido */
/* [...] where nome = 'João' OR nome = 'Maria'; */

/* LIKE */
/* Esse filtro permite que achemos em uma coluna um nome apenas por seus caracteres. */
/* 
'%o' : significa que todos os caracteres antes do 'o' não importam, entao ele vai buscar todas as palavras que terminam com 'o'
'%r%' : significa que todos os caracteres antes e depois do 'r' não serao considerados. Ou seja: a palavra que contenha 'r'
'm%' : Pela logica agora, nesse caso somente as palavras começadas com 'm'
'm%a' : nesse caso ele deve iniciar com 'm' e terminar com 'a'
*/
/*
'_ _ _ _' : com o underline ele funcionada da seguinte maneira, tem um numero exato de caracteres, nesse nosso exemplo vamos usar 4. 
ele busca o caractere especifico de acordo com a busca. Ex a baixo

'_ _ _ e' : vai buscar todos os nomes de 4 letras que terminam com a letra 'e'
'_ _ s e' : vai buscar todos os nomes de 4 letras que terminam com as letras 's' e 'e' nessa ordem.
Obs: é possivel combinar o % e o _
Ex.: '%d_'
Nesse caso de cima nao importa quantos e quais caracteres vem antes do 'd', mas diz que depois do 'd' podemos ter somente mais 1 caracter, 
nao importando qual seja.
*/
/* exemplos: */
select * from aluno where nome LIKE('%o');
select * from aluno where nome LIKE('%e%');
select * from aluno where nome LIKE('b%');
select * from aluno where nome LIKE('f%o');

select * from aluno where nome LIKE('_____o');
select * from aluno where nome LIKE('b______o');
select * from aluno where nome LIKE('_____o');
select * from aluno where nome LIKE('___l___');

select * from aluno where nome LIKE('_u%');
select * from aluno where nome LIKE('S__l%');
/* Aparentemente nao diferencia minuscula de maiuscula */

/* ORDER BY */
/*
Agrupar por:
ASC = Ascendente (crescente), DESC = Descentende (decrescente)

Obs: Se não colocarmos se é ASC ou DESC, por padrao ele entra como se fosse ASC
Obs2: Importante seguirmos a ordem de montagem da query (query = lista de instrução)
Ex.: select, from, where e order by
Obs3: O where e order by são opcionais.
*/

select * from aluno ORDER BY nome;  /* ASC por padrao */
select * from aluno where idade between 17 and 23 ORDER BY nome DESC;
select * from aluno where nome LIKE('s%') ORDER BY nome ASC;

/* UPDATE */
/* Obs: No workbanch do MySql, para funcionar o update e insert, devemos ir em edit > preferences > SQL editor e desmarcar o Safe Updates. 
Depois disso devemos reconectar o server em query > reconnect to server. Aí pronto, só usar. */
/* O where nesse caso é obrigatorio. Se nao colocarmos o WHERE, ele faz um update em todos os registros */

update aluno set idade = 34 where nome = 'Sicrano';
update aluno set idade = 32, cpf = 42366699900 where nome = 'Sicrano'; /* Podemos tambem trocar mais de 1 atributo de 1 vez*/

/* DELETE */
insert into aluno(nome,cpf,idade,telefone) value('Dito Cujo',42366677788,97,'1526544358');  /* Só para ter o que excluir */
insert into aluno(nome,cpf,idade,telefone) value('Dito Cujo2',42366677799,99,'2126544358');
insert into aluno(nome,cpf,idade,telefone) value('Dito Cujo3',42366677733,100,'5426544358');

delete from aluno where idade between 97 and 99; /* Deleta o registro */
delete from aluno where idade in(97,99) or idade = 100;

/* DESC */
/* Descreve toda a infromacao da tabela */
/* Esse comando só funciona no MySQL */
desc aluno;

/* ------ ALTER TABLE ------ */
/* Alteracoes na tabela */

/* ADD - Adiciona coluna */
/* after - estou dizendo para add depois da coluna telefone | primeira coluna seria o FIRST */
alter table aluno add sobrenome varchar(50) after nome;
alter table aluno add sexo char(1);

/* Só preenchendo os novos valores e add uma mulher */
insert into aluno(nome,sobrenome,cpf,idade,telefone,sexo) value('Jane','Doe',42366800065,41,'9826544354','F');
update aluno set sobrenome = 'De Tal', sexo = 'M' where nome = 'Fulano';
update aluno set sobrenome = 'Da Silva', sexo = 'M' where nome = 'Beltrano';
update aluno set sobrenome = 'Silva', sexo = 'M' where nome = 'Sicrano';
update aluno set sobrenome = 'Dos Cafundós', sexo = 'M' where nome = 'Siclano';

/* MODIFY */
/* Modifica coluna */
/* Dei um desc para compararmos o antes e depois do sobrenome, repare no numero do varchar */
desc aluno;
alter table aluno modify column sobrenome varchar(30);
desc aluno;

/* DROP */
/* delete de coluna */
alter table aluno drop NOMEDACOLUNA;