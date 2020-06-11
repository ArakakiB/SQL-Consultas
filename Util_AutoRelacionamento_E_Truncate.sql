/* -------- Auto Relacionamento -------- */
/* onde a tabela se relaciona com ela mesma */
/* só add a coluna que vai se relacionar com outra depois */
alter table funcionario add column fk_idmatricula_supervisor int;

/* Justamente aqui conseguimos ver o autorelacionamento. Perceba que é para a mesma tabela */
alter table funcionario add constraint fk_funcionario_supervisor
foreign key(fk_idmatricula_supervisor) references funcionario(idmatricula);

desc funcionario;

/* Mas pra que uma tabela se autorelacionar? Um bom exemplo vamos mostrar agora
nessa nossa tabela funcionario, vamos ter um supervisor, onde um funcionario pode
supervisionar outro. Nesse exemplo a Fátima vai supervisionar a Bianca */
/* Perceba que agora a Bianca tera um supervisor na coluna fk_idmatricula_supervisor */
update funcionario set fk_idmatricula_supervisor = 110 where idmatricula = 100;

/* add mais um funcionario que sera supervisor */
insert into funcionario(
    nome, funcao
)values(
    'Pedro', 'Gerente de TI'
);

update funcionario set fk_idmatricula_supervisor = 354 where idmatricula = 127;

/* Aqui a fatima acaba virando supervisora de mais 2 funcionarios, totalizando 3 */
update funcionario set fk_idmatricula_supervisor = 110 where idmatricula in (221, 353);

/* TRUNCATE - Resetando tabela */
/* Nao vou executar esses comandos para nao perder minhas tabelas */
/* Podemos usar o truncate para limpar tabelas, diferente do delete, ele reseta a auto-incrementacao e limpa todos os registros */
truncate table gasto;

/* conseguimos truncar uma tabela que possui a foreign key */
-- truncando a table onde está a foreign key
select * from telefone;
truncate table telefone;

-- truncando a tabela referência
/* mas nao conseguimos truncar a tabela referencia */
/* a nao ser que desfaçamos a referencia dessa maneira */
/* essa maneira desfaz todas as referencias do DB (se bem intendi) */
set foreign_key_checks = 0; /* Podemos voltar a referencia colocando o numero 1 */
truncate table aluno;
truncate table curso;


select * from aluno;
select * from telefone;
select * from endereco;
select * from curso;
select * from aluno_curso;
select * from gasto;
select * from projeto_funcionario;
select * from projeto;
select * from funcionario;
select * from disciplina;
select * from professor;
desc aluno;
desc telefone;
desc endereco;
desc curso;
desc aluno_curso;
desc gasto;
desc projeto_funcionario;
desc projeto;
desc funcionario;
desc disciplina;
desc professor;