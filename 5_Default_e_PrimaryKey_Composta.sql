use comandos_sql;

select * from aluno;
select * from telefone;
select * from endereco;
select * from curso;
select * from aluno_curso;
select * from gasto;
desc aluno;
desc telefone;
desc endereco;
desc curso;
desc aluno_curso;
desc gasto;

/* add mais 2 colunas na tabela aluno_curso */
alter table aluno_curso add column data_inscricao_curso date;
alter table aluno_curso add column valor_pago_curso float(10, 2);

/* Pegando os dados da tabela aluno e passado para a aluno_cruso */
update aluno_curso set 
	data_inscricao_curso = (select data_inscricao_curso from aluno where idaluno = 4),
    valor_pago_curso = (select valor_pago_curso from aluno where idaluno = 4)
where fk_idaluno = 4;

update aluno_curso set 
	data_inscricao_curso = (select data_inscricao_curso from aluno where idaluno = 1),
    valor_pago_curso = (select valor_pago_curso from aluno where idaluno = 1)
where fk_idaluno = 1;

update aluno_curso set 
	data_inscricao_curso = (select data_inscricao_curso from aluno where idaluno = 2),
    valor_pago_curso = (select valor_pago_curso from aluno where idaluno = 2)
where fk_idaluno = 2;

update aluno_curso set 
	data_inscricao_curso = (select data_inscricao_curso from aluno where idaluno = 3),
    valor_pago_curso = (select valor_pago_curso from aluno where idaluno = 3)
where fk_idaluno = 3;

/* Como ja passamos para a outra tabela, podemos excluir da aluno */
alter table aluno drop column data_inscricao_curso;
alter table aluno drop column valor_pago_curso;


/* DEFAULT */
/* Coloca um valor padrao para uma coluna, entao quando formos add registros nela, nao precisamos passar nenhum valor
a nao ser que queiramos */
/* Nesse caso abaixo eu coloco o valor 1 como default, entao toda vez que for add um registro, nao precisamos passar mais ele (a nao ser que queira) */
/* se dermos um desc conseguimos ver o valor padrao setado */
alter table aluno modify column ativo_sn int default 1;

/* testando o default. Perceba que estou add sem a coluna ativo_sn, e quando olharmos na tabela, vai estar com o valor default */
insert into aluno(sexo, email, nome, cpf, data_nascimento)
values('M', 'john@hotmail.com.br', 'John', '444.111.111-15', '1989-01-06');

/* aqui vamos usar o default para no momento que cadastrarmos um aluno a data de inscricao pegue a data atual */
/* aqui usamos o current_timestamp ao invez do curdate(), porque se colocarmos o curdate() ai, o sgbd tenta executa-lo e da erro
colocando o current_timestampo ele interpreta como se fosse uma variavel, entao da certo */
/* tambem colocamos o datetime, ao invez do data, mas isso é porque o timestamp so suporta o datetime, 
porem ele mantem as informacoes do date que tava antes */
alter table aluno_curso modify column data_inscricao_curso datetime default current_timestamp;

/* testando */
insert into aluno_curso(fk_idaluno, fk_idcurso, valor_pago_curso) values(4, 3, 1001.05);


/* PRIMARY KEY COMPOSTA */
/* Chave primaria so temos uma em cada tabeka. Isso ja sabemos.
Mas podemos ter mais de 1 coluna em uma chave primaria. Isso significa que ela é uma chave composta */

/* Vou remover a chave primaria para torna-la composta */
alter table aluno_curso drop column id_alunocurso;

/* pk = primary key */
/* Aqui passo que as 3 colunas serao da minha chave primaria, ou seja cada coluna tera o valor de registro unico
e pertencente a minha pk_aluno_curso */
/* assim ele cira uma coluna chamada  */
alter table aluno_curso add constraint pk_aluno_curso primary key(fk_idaluno, fk_idcurso, data_inscricao_curso);


/* So inserindo mais dados no nosso banco */

create table projeto_funcionario(
	codigo_projeto int,
	matricula_funcionario int,
	nome_projeto varchar(100) not null,
	nome_funcionario varchar(50) not null,
	funcao_funcionario varchar(50) not null,
	telefone_funcionario varchar(20),
	data_criacao_projeto datetime default current_timestamp,
	horas_estimadas int not null,
	horas_realizadas int
);

alter table projeto_funcionario add constraint pk_projeto_funcionario primary key(codigo_projeto, matricula_funcionario);

/* Essa é linha é so para mostrar que conseguimos alterar o nome da tabela dessa maneira:
alter table projeto_funcionario change column data_cricao_projeto data_criacao_projeto datetime default current_timestamp;
*/

/* Nao vou colocar aqui as horas_realizadas e nem telefone porque vou trata-las depois */
insert into projeto_funcionario
	(codigo_projeto, matricula_funcionario, nome_projeto, nome_funcionario, funcao_funcionario, horas_estimadas)
values
	(1, 100, 'Matricula Online', 'Bianca', 'Analista de Atendimento', 200);

insert into projeto_funcionario
	(codigo_projeto, matricula_funcionario, nome_projeto, nome_funcionario, funcao_funcionario, horas_estimadas)
values
	(1, 110, 'Matricula Online', 'Fátima', 'Gerente de Atendimento', 100);

insert into projeto_funcionario
	(codigo_projeto, matricula_funcionario, nome_projeto, nome_funcionario, funcao_funcionario, horas_estimadas)
values
	(1, 127, 'Matricula Online', 'Miguel', 'Analista Programador Sênior', 500);
    
insert into projeto_funcionario
	(codigo_projeto, matricula_funcionario, nome_projeto, nome_funcionario, funcao_funcionario, horas_estimadas)
values
	(2, 221, 'Economia de Papel', 'Laura', 'Analista Qualidade', 200);
    
insert into projeto_funcionario
	(codigo_projeto, matricula_funcionario, nome_projeto, nome_funcionario, funcao_funcionario, horas_estimadas)
values
	(3, 221, 'Notas Online', 'Carlos', 'Analista Administrativo', 150);
    
select * from projeto_funcionario;
desc projeto_funcionario;