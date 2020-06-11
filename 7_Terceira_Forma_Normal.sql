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

/* so criando outra tabela */
create table disciplina(
    iddisciplina int auto_increment,
    descricao varchar(50) not null,
    carga_horaria int,
    codigo_professor int,
    nome_professor varchar(50),
    email_professor varchar(100),
    fk_idcurso int,
    constraint pk_iddisciplina primary key(iddisciplina)
);

alter table disciplina add constraint fk_curso_disciplina
foreign key(fk_idcurso) references curso(idcurso);

/* populando */
insert into disciplina(
    descricao, carga_horaria, codigo_professor, 
    nome_professor, email_professor, fk_idcurso
)values(
	'NodeJs', 7, 100,
    'Jorge', 'jorge@teste.com.br', 1
);

insert into disciplina(
    descricao, carga_horaria, codigo_professor, 
    nome_professor, email_professor, fk_idcurso
)values(
	'Express', 2, 120,
    'Pedro', 'pedro@teste.com.br', 1
);

insert into disciplina(
    descricao, carga_horaria, codigo_professor, 
    nome_professor, email_professor, fk_idcurso
)values(
	'MongoDB', 5, 130,
    'Julia', 'julia@teste.com.br', 1
);

/* anomalias de inserção (redundância de dados, dados inconsistentes) */
/* Nesse caso é porque o jorge ja tem um email, ele teoricamente nao poderia ter 2 nessa mesma tabela */
insert into disciplina(
    descricao, carga_horaria, codigo_professor, 
    nome_professor, email_professor, fk_idcurso
)values(
	'EJS', 3, 100,
    'Jorge', 'jorge1010@teste.com.br', 1
);

/* anomalias de exclusão (perder registros importantes) */
/* Se escluirmos o professor perdemos tambem os dados do curso :\ */
delete from disciplina where codigo_professor = 120 and descricao = 'Express';
select * from disciplina where codigo_professor = 120 and descricao = 'Express';

/* anomalias de atualização (informações inconsistentes, redundância no update) */
/* O mesmo acontece cmo o update */
update disciplina set nome_professor = 'George' where codigo_professor = 100;

/* Para evitar essas anomalias de cima, aplicamos a 3FN */
/* --- Regras da 3FN --- */
/* 
- Estar na 1FN e 2FN
- Nao possuir dependencias transitivas
(Todas as colunas nao chave devem depender exclusivamente da chave primaria, ou seja, 
nao podem depender de outra coluna nao chave)
*/
/* Analisando nossa tabela disciplina, podemos constatar que a coluna nome_professor e email sao dependentes da coluna codigo professor 
e a coluna email é dependente tambem do nome_professor*/
/* vamos criar outra tabela */
create table professor(
    idprofessor int auto_increment,
    nome varchar(50) not null,
    email varchar(100),
    constraint pk_professor primary key(idprofessor)
);

/* so para o jorge ficar com o mesmo email para podermos dar um distinct depois */
update disciplina set email_professor = 'jorge@teste.com.br'
where codigo_professor = 100;

/* copiando da disciplina para a professor */
insert into professor(
    idprofessor,
    nome,
    email
)
select distinct
    codigo_professor,
    nome_professor,
    email_professor
from 
    disciplina;
    
/* ja passei para a tabela professor, entao nao vou mais precisar */
alter table disciplina drop column nome_professor;
alter table disciplina drop column email_professor;

/* Apesar dele aparecer que o rename ta errado, ele funfa */
alter table disciplina rename column codigo_professor to fk_idprofessor;

alter table disciplina add constraint fk_disciplina_professor
foreign key(fk_idprofessor) references professor(idprofessor);

