/* Somente com a primeira forma normal, podemos ainda ter varias inconsistencias de dados, como
excluir dados importante, nao manter historico ou fazer atualizações erradas, por isso vamos 
seguir com a segunda forma normal */
/*
--- Regras da 2FN ---
- Primeiro a tabela precisa estar na primeira forma normal 
(ter uma identificacao unica para cada registro e atributos com valores atomicos)
- Não possuir possuir dependencias parciais
(todos os atributos nao chave devem ser total e funcionalmente dependentes da chave primaria)
*/
/* Obs: A 2FN só é aplicada nas chaves primarias compostas */
/* Na projeto_funcionario por exemplo nossas colunas que tem dependencia são as colunas que nao sao chave composta
ou seja, todas que nao sao a codigo_projeto e matricula_funcionario, porem, as unicas com dependencia total, sao as
colunas horas_estimadas e horas_realizadas, porque se pararmos para pensar sao as unicas que realmente dependem da chave composta. 
As outras dependentes sao chamadas de dependentes parciais, ou seja, dependem de apenas 1 coluna da chave composta. */

select * from aluno;
select * from telefone;
select * from endereco;
select * from curso;
select * from aluno_curso;
select * from gasto;
select * from projeto_funcionario;
select * from projeto;
select * from funcionario;
select * from projeto_funcionario2;
desc aluno;
desc telefone;
desc endereco;
desc curso;
desc aluno_curso;
desc gasto;
desc projeto_funcionario;
desc projeto;
desc funcionario;
desc projeto_funcionario2;

/* Lembrando que aqui estou criando com a primary key como constraint porque posso renomear. É a forma indicada de se fazer
Obs: nao confundir com a criacao de chave primaria com chave estraingeira, porque a chave estrangeira criamos no alter table */
create table projeto(
	idcodigo int auto_increment,
    data_criacao datetime default current_timestamp,
    nome varchar(100) not null,
    constraint pk_projeto primary key(idcodigo)
);

create table funcionario(
    idmatricula int auto_increment,
    nome varchar(50) not null,
    funcao varchar(50) not null,
    telefone varchar(20),
    constraint pk_funcionario primary key(idmatricula)
);

/* a tabela projeto_funcionario2 vai substituir a projeto_funcionario. 
Quando eu for substituir vou renomea-la para projeto_funcionario.
Estou criando essa porque a outra ainda contem os dados dos registros que ainda vou upar para as outras 2 tabelas
auxiliares fucionario e projeto. E tambem a propria projeto_funcionario2 */
create table projeto_funcionario2(
    fk_idcodigo int,
    fk_idmatricula int,
    horas_estimadas int not null,
    horas_realizadas int,
    constraint pk_projeto_funcionario 
    primary key( fk_idcodigo,  fk_idmatricula)
);

alter table projeto_funcionario2 add constraint
foreign key(fk_idcodigo) 
references projeto(idcodigo);
 
alter table projeto_funcionario2 add constraint
foreign key(fk_idmatricula) 
references funcionario(idmatricula);

/* query para migração dos registros de funcionários */
/* O distinct serve para trazer somente 1 registro unico. Por exemplo, se tivessemos duas Biancas
registradas com os mesmos dados, ele so traria 1x. Ate porque como estamos passando para outra tabela
se nao usassemos o distinct ele traria 2 resultados e daria erro para adicionar a outra tabela */
insert into funcionario(idmatricula, nome, funcao, telefone)
select distinct
	matricula_funcionario,
    nome_funcionario,
    funcao_funcionario,
    telefone_funcionario
from 
	projeto_funcionario;

/* query para migração dos registros de projeto */
/* Nesse caso se usarmos somente o distinct ele nao vai nos trazer somente 1 dado do nome do projeto
porque a data de criacao é diferente, para isso vamos passar a data mais antiga para todos os registros do projeto */
/* pegamos a primeira data de todos os registros do porjeto tal */
select * from projeto_funcionario where codigo_projeto = 2 order by data_criacao_projeto asc limit 1;
select * from projeto_funcionario where codigo_projeto = 1 order by data_criacao_projeto asc limit 1;
/* passamos essa data para o projeto de id 2 */
update projeto_funcionario set data_criacao_projeto = '2020-06-06 16:48:21' where codigo_projeto = 2;
update projeto_funcionario set data_criacao_projeto = '2020-06-06 16:44:37' where codigo_projeto = 1;
/* ajustando um pequeno erro */
update projeto_funcionario set codigo_projeto = 3 where nome_projeto = 'Inscrição Online';

insert into projeto(idcodigo, data_criacao, nome)
select distinct
	codigo_projeto,
    data_criacao_projeto,
    nome_projeto
from
    projeto_funcionario;
    
/* so arrumando uma coisinha */
update projeto set data_criacao = '2020-06-06 19:44:37' where idcodigo = 3;

/* passando da projeto_funcionario para a projeto_funcionario2 */
insert into projeto_funcionario2(
fk_idcodigo, fk_idmatricula, horas_estimadas, horas_realizadas
)
select 
    codigo_projeto, matricula_funcionario, 
    horas_estimadas, horas_realizadas
from 
    projeto_funcionario;

/* nao precisamos mais da projeto_funcionario */
drop table projeto_funcionario;

/* renomear tabela */
rename table projeto_funcionario2 to projeto_funcionario;

select * from projeto_funcionario;




