/* -- auto_increment (valor padrão é 1) */
/* Basicamente podemos a qualquer momento mudar o numero do nosso autoincrement para mais (nunca para menos)
Se tivermos os registros 1 e 2, podemos fazer com que o terceiro seja 353 por exemplo */
/* Isso sig que qualquer registro que add depois vai ser sequencia do 353 (354) */
alter table NOMETABELA auto_increment = 353;

/* Mas nao conseguimos colocar um auto increment menor.
Ex: se nossos registros forem 200 e 201, nao conseguimos colocar um auto increment de 100 
O que podemos fazer é mudar manualmente o ID de um unico registro, mas ao add outro, ele vai contar do auto_increment maximo */

/* Realocando posicao de uma coluna */
/* aqui vou realocar a coluna idaluno porque ela esta como ultima coluna e quero passar para a primeira */
/* Vou dar um show create table pra ver como foi criada a coluna idaluno 
se copiarmos o create table, vamos ver como a coluna idaluno foi criada, ai é so pegar ela e colocar no alter table a baixo */
show create table aluno;
/* O first sig que vai ficar em primeiro */
alter table aluno modify `idaluno` int(11) NOT NULL AUTO_INCREMENT first;

/* o after pra ser depois de tal tabela */
alter table aluno modify `ativo_sn` int(11) DEFAULT '1' after email;


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