/* Aqui eu crio meu DB efetivamente */
/* As explicacoes mais detalhadas dos comandos e afins daq estao no 2_Comandos_Explicacoes_Keys.sql */

/* Vou excluir pra criar dnv */
drop table aluno;

/* colinha de select all e desc */
use comandos_sql;
select * from aluno;
select * from telefone;
select * from endereco;
select * from curso;
select * from aluno_curso;
desc aluno;
desc telefone;
desc endereco;
desc curso;
desc aluno_curso;
/* ---------------------------- */

/* o idaluno to criando como uma chave artificial, que auto incrementa e passo que é chave primaria */
CREATE TABLE aluno (
    sexo char(1),
    idade int,
    data_inscricao_curso date,
    data_nascimento date,
    valor_pago_curso float(10,2),
    ativo_sn int,
    nome varchar(25),
    cpf varchar(14),
    email varchar(150),
    idaluno int auto_increment PRIMARY KEY
);

/* No "tipo" do telefone, sabemos que nossas opções são "res, cel e com", mas se colocarmos um dado qualquer com 3 caracteres ele vai entrar, e nao é o que queremos. 
Então, nesse caso podemos usar o 'enum'. Ele so vai permitir os dados 'res','cel' e 'com'. Pode ser usado para int tambem */
CREATE TABLE telefone (
    idtelefone int auto_increment PRIMARY KEY,
    numero varchar(20),
    tipo enum('res','cel','com')
);

insert into 
	aluno(sexo, idade, data_inscricao_curso, data_nascimento, valor_pago_curso, ativo_sn, nome, cpf, email)
	values('M',17,'2020-01-15','1996-02-28',1600.56,1,'Fulano','000.111.222-33','fulano@gmail.com');
insert into 
	aluno(sexo, idade, data_inscricao_curso, data_nascimento, valor_pago_curso, ativo_sn, nome, cpf, email)
	values('M',29,'2020-02-10','1996-02-03',1500.16,1,'Sicrano','000.111.222-00','sicrano@gmail.com');
insert into 
	aluno(sexo, idade, data_inscricao_curso, data_nascimento, valor_pago_curso, ativo_sn, nome, cpf, email)
	values('F',21,'2020-03-01','1995-07-31',1850.56,1,'Siclana','000.111.222-11','siclana@gmail.com');
insert into 
	aluno(sexo, idade, data_inscricao_curso, data_nascimento, valor_pago_curso, ativo_sn, nome, cpf, email)
	values('M',41,'2020-01-30','1996-02-28',1205.50,0,'Beltrano','000.111.222-22','beltrano@gmail.com');
insert into 
	aluno(sexo, idade, data_inscricao_curso, data_nascimento, valor_pago_curso, ativo_sn, nome, cpf, email)
	values('F',18,'2020-01-15','2002-02-28',1105.50,0,'Jane','423.111.222-22','jane@hotmail.com');

insert into telefone(numero,tipo) values('11 2222-3333','res');
insert into telefone(numero,tipo) values('21 3333-2222','com');
insert into telefone(numero,tipo) values('11 4444-3333','cel');
insert into telefone(numero,tipo) values('12 5555-4444','res');
insert into telefone(numero,tipo) values('11 1111-4444','com');

/* Add constrant na telefone vinda da aluno */
alter table telefone add column fk_idaluno int;
/* resumindo: add uma ligacao com o nome de fk_aluno_telefone, ou seja que vai de aluno para telefone, 
com a chave estrangeira chamada fk_idaluno, ou seja, o idaluno é a chave estrangeira 
e essa chave estrangeira é a coluna idaluno que vem da nossa tabela aluno */
alter table telefone add constraint fk_aluno_telefone foreign key (fk_idaluno) references aluno (idaluno);

update telefone set fk_idaluno = 3 where numero in('11 2222-3333', '11 4444-3333', '11 1111-4444');
update telefone set fk_idaluno = 1 where numero in('21 3333-2222');
update telefone set fk_idaluno = 2 where numero in('12 5555-4444');

CREATE TABLE ENDERECO (
    idendereco int auto_increment PRIMARY KEY,
    logradouro varchar(100),
    numero varchar(10),
    complemento varchar(20),
    bairro varchar(100),
    cidade varchar(50),
    estado char(2),
    fk_idaluno int
);

ALTER TABLE ENDERECO ADD CONSTRAINT fk_aluno_endereco
    FOREIGN KEY (fk_idaluno)
    REFERENCES ALUNO (idaluno);

INSERT INTO endereco(logradouro,numero,complemento,bairro,cidade,estado,fk_idaluno) values('Avenida Paulista','1500','ap315','Bela Vista','São Paulo','SP',3);
INSERT INTO endereco(logradouro,numero,complemento,bairro,cidade,estado,fk_idaluno) values('Rua Francisco Sá','10','','Gutierrez','Belo Horizonte','MG',1);
INSERT INTO endereco(logradouro,numero,complemento,bairro,cidade,estado,fk_idaluno) values('Avenida Dom Emanuel','300','','Center','Fortaleza','CE',2);
INSERT INTO endereco(logradouro,numero,complemento,bairro,cidade,estado,fk_idaluno) values('Rua Miramar','1200','ap112','Rocas','Natal','RN',4);
INSERT INTO endereco(logradouro,numero,complemento,bairro,cidade,estado,fk_idaluno) values('Rua João de Abreu','650','','Setor Oeste','Goiânia','GO',5);


CREATE TABLE CURSO (
    idcurso int auto_increment PRIMARY KEY,
    descricao varchar(50)
);

insert into curso(descricao) values('Curso Completo do Desenvolvedor NodeJS e MongoDB');
insert into curso(descricao) values('Desenvolvedor Multiplataforma Android e IOS');
insert into curso(descricao) values('Desenvolvimento Web com Angular');
insert into curso(descricao) values('Desenvolvimento Web Completo 2019');

/* Essa tabela aluno curso é uma tabela n:n (muitos para muitos), que vai conter
a relacao entre curso e aluno apenas. */
CREATE TABLE ALUNO_CURSO (
    id_alunocurso int auto_increment PRIMARY KEY,
    fk_idaluno int,
    fk_idcurso int
);

ALTER TABLE ALUNO_CURSO ADD CONSTRAINT fk_aluno_curso
    FOREIGN KEY (fk_idaluno)
    REFERENCES ALUNO (idaluno);
 
ALTER TABLE ALUNO_CURSO ADD CONSTRAINT fk_curso_aluno
    FOREIGN KEY (fk_idcurso)
    REFERENCES CURSO (idcurso);

insert into aluno_curso(fk_idaluno, fk_idcurso)values(1, 3);
insert into aluno_curso(fk_idaluno, fk_idcurso)values(1, 4);
insert into aluno_curso(fk_idaluno, fk_idcurso)values(2, 2);
insert into aluno_curso(fk_idaluno, fk_idcurso)values(3, 1);
insert into aluno_curso(fk_idaluno, fk_idcurso)values(3, 2);
insert into aluno_curso(fk_idaluno, fk_idcurso)values(3, 3);
insert into aluno_curso(fk_idaluno, fk_idcurso)values(3, 4);
insert into aluno_curso(fk_idaluno, fk_idcurso)values(4, 1);

/* NULL e NOT NULL */
/* Por convenção nossos registros de tabela aceitam um dado nulo (null), Se não quisermos que ele seja nulo devemos usar o NOT NULL */
alter table telefone modify numero varchar(20) not null;
alter table telefone modify tipo enum('res','cel','com') not null;
alter table telefone modify fk_idaluno int not null;
/* Apesar de a minha coluna fk_idaluno ja conter dados da minha constraint, eu consegui passar para ele nao ser nao nulo e as conf
da constraint continuaram, mas o nao nulo funcionou :D */

/* Unique Constraint */
/* Indica que os valores de uma determinada coluna devem ser unicos para todos os registros. Aparece no desc como UNI
Ou seja: Os valores da coluna não podem se repetir.
Ex. de uso no create table: cpf varchar(14) unique,
Mas lembrando que é melhor nos adicionarmos o 'unique' a coluna atraver do alter table pois assim podemos dar um nome a constraint */
/* por convensao o nome da constraint colocamos uc = unique constraint, NOMETABELA, NOMECOLUNA */
/* alter table aluno add constraint uc_NOMETABELA_NOMECOLUNA unique(NOMENOMECOLUNA); */
alter table aluno add constraint uc_aluno_cpf unique(cpf);
alter table aluno add constraint uc_aluno_email unique(email);
alter table endereco add constraint uc_endereco_fkidaluno unique(fk_idaluno);