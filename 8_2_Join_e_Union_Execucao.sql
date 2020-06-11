select * from aluno;
select * from endereco;

/* Temos essas 2 formas de fazer o join manual, onde a segunda é a mais aconselhada */
/* Quando fazemos o join so usando selects dessa maneira manual nós temos que lembrar:
- O primeiro select (primeiro nivel) deve conter 2 ou mais selects;
- O segundo select (segundo nivel)(os 2 ou mais) é o que representa a coluna que queremos que apareca
Como podemos ver, no select segundo nivel temos um where, que é o que liga nossos selects de segundo nivel (colunas) 
como podemos ver no nosso segundo exemplo temos um select de terceiro nivel
- O terceiro select (terceiro nivel) serve apenas para trazermos o parametro do que queremos achar
Ex teorico: Se quisermos achar o nome de uma pessoa que esta na tabela 1 e qual é o seu respectivo estado na tabela 2
nos vamos precisar encontrar a relação, que seria a chave unica (idaluno) na tabela aluno e seu correspondente na tabela
endereco (fk_idaluno), mas eu quero o nome da "Jane" e nao sei qual é o id dela, entao ao invez de passar o id direto,
eu acesso o id atravez do nome, buscando com um where.
Lembrando que dei o exemplo buscando pelo nome, mas eu poderia buscar por outra caracteristica unica tambem. */

select (select nome from aluno where idaluno = 3), (select cidade from endereco where fk_idaluno = 3);
select (select nome from aluno where idaluno = (select idaluno from aluno where nome = 'Rosa')) as aluno_nome, 
(select cidade from endereco where fk_idaluno = (select idaluno from aluno where nome = 'Rosa')) as endereco_cidade;


/* -------------- JOIN -------------- */
/* Mostra todas as tabelas do banco em uso */
show tables;

select * from aluno;
select * from telefone;

/* ------- Left Join ------- */
/* O left join traz todos os resultados a esquerda, que esquerda?
Olhando para o nosso cod no trecho "aluno left join telefone", o que esta a esquerda é a tabela aluno */
/* é como se ele pegasse todos os registros da direita que tem relacao com a esquerda e juntasse com a esquerda
por isso imagine que se nao tivermos registros do lado direito, eles sao colocados da mesma maneira de modo nulo, porque a relacao 
é da ESQUERDA para a direita nesse caso */
/* resumindo para o nosso caso, todos os alunos (esquerda) vao aparecer mesmo que nao tenha telefone, 
e nos registros do telefone (para os alunos que nao tem telefone) vai aparecer nulo porque nao temos esses registros */
/* no trecho "on (aluno.idaluno = telefone.fk_idaluno)" é onde fazermos uma relacao entre as 2 tabelas, se nao nosso join nao sabe
como interligar as 2. Nesse caso liganos nossa idaluno da tabela aluno com a fk_idaluno da tabela telefone, que é a relacao entre os registros
de ambas as tabelas */
select * from aluno left join telefone on (aluno.idaluno = telefone.fk_idaluno);
    
select * from aluno left join telefone on (aluno.idaluno = telefone.fk_idaluno) where sexo = 'F';

select
    idaluno, nome, idtelefone, numero
from
    aluno 
left join 
    telefone on (aluno.idaluno = telefone.fk_idaluno)
where
    nome = 'Rosa';

/* Aqui faremos 2 left joins, a ideia é a mesma, sempre juntando a da direita na da esquerda */    
select * from curso;
select * from disciplina;
select * from professor;

select 
    *
from
    curso 
left join disciplina on (curso.idcurso = disciplina.fk_idcurso)
left join professor on (disciplina.fk_idprofessor = professor.idprofessor)
where
    idcurso = 1;
    
/* Vamos entender o que significa essas letras com ponto do lado (finalmente!) */
/* 
- Primeiro vamos afirmar que sempre em um join devemos fazer o select de colunas especificas e nao de todas 
Como bem podemos ver a nossa tabela curso e a nossa tabela disciplina contem uma coluna com o mesmo nome,
que é a 'descricao'. Se tentarmos dar nosso select sem dizer de qual tabela é, vai dar erro. Mas...
Para isso nos temos as apilidos, que usamos como 'as'
O 'as' serve para apilidar nao so colunas como tambem para apilidar tabelas dentro da nossa consulta SQL
Mas como fazemos isso? voce deve estar perguntando... Simples!
Repare que no from nos colocamos um 'as c' depois do curso, isso significa que agora minha tabela curso é representada pela letra c
e se olharmos no select vamos ver que no idcurso por exemplo nos colocamos antes uma letra c seguido de um ponto,
isso para indicar que a coluna idcurso vem da nossa tabela curso que esta sendo representada pela letra 'c'
*/
/* o as dp c.descricao e do d.descricao é so para apelidar para a visualizacao mesmo (para aparecer o nome da tabela no select) */
select
    c.idcurso, 
    c.descricao as curso, 
    d.iddisciplina, 
    d.descricao as disciplina, 
    p.idprofessor, 
    p.nome as professor,
    now() as data_atual
from
    curso as c left join disciplina as d on (c.idcurso = d.fk_idcurso)
    left join professor as p on (d.fk_idprofessor = p.idprofessor)
where 
    idcurso = 1;
    
    
    

/* ------- Right Join ------- */
/* No right join a diferenca é que ao invez de ele pegar o da direita e juntar no da esquerda,
ele pega o da esquerda e junta no da direita.
Outra forma de explicar: Ele traz todos os registros do da direita, mesmo que sem relacao com o da esquerda */
/* Na linha de baixo por exemplo ja conhecemos */
select * from curso as c left join disciplina as d on (c.idcurso = d.fk_idcurso);

/* Aqui usando o right, vamos pegar todos os registros da tabela da direita (disciplina) e trazer as relacoes da tabela curso */
/* repare que na tabela disciplica temos a disciplina na tabela descricao "Express", esse registro nao tem relacao com a tabela curso,
mas mesmo assim aparece porque colocamos para aparecer todos os dados da nossa tabela a direita (disciplina) */
select * from curso as c right join disciplina as d on (c.idcurso = d.fk_idcurso);

select * from curso;
select * from disciplina;

/* ------- Inner Join ------- */
/* No inner join ao invez de trazermos todos os registros de uma tabela especifica, vamos trazer somente os registros
que ha relacionamento certo entre as 2 tabemas, caso nao haja, nao vai aparecer */
/* nessa linha de baixo comparando com o right join podemos ver que nao mais aparecer a disciplica com a descricao "Express",
isso porque ela nao tem relacao com a tabela curso. e como o inner join nao prioriza trazer todos os dados de nenhuma tabela, 
entao o express nao é retornado */
select * from curso as c inner join disciplina as d on (c.idcurso = d.fk_idcurso);



/* ------- UNION ------- */
/* o union une diferentes consultas */
/* Só pode ser usado se as colunas estiverem na mesma ordem e se for o mesmo numero de colunas */
/*
union - distinct
union all - não faz distinct
*/

/* mesmo número de colunas */
/* aqui vemos que ele coloca os resultados na parte de baixo */
select 100, 500
union all
select 100, 300
union all
select 500, 700;

/* mesma ordem */
/* Aqui podemos ver que na coluna c2 nos colocamos 200 e depois 'uva'. Ta errado issodae
Masss no MySQL ele aceita colocar dados de tipos diferentes na mesma coluna */
select 100 as c1, 200 as c2, 'abacaxi' as c3
union
select 500, 'uva', 700;

/* union (distinct) x union all */
/* repare que com o unio ele retorna somente valores distintos, ou seja, vai retornar so 1 morango */
/* repare tambem que podemos ordenar */
select 'morango' as c1
union
select 'uva'
union
select 'morango'
union
select 'abacaxi'
order by c1;

/* ------- UNION ALL ------- */
/* mesmo exemplo de cima, mas dessa vez ele retorna os 2 morangos */
select 'morango' as c1
union
select 'uva'
union all
select 'morango'
union all
select 'abacaxi'
order by c1;

/* exemplo com tabela */
/* juntando o email dos alunos e professores e dizendo quem é aluno e professor */
/* esse 'aluno' e 'professor' é so uma coluna que add, se exucutarmos ela sozinha vamos ver
que o nome 'aluno' fica do lado de cada aluno */
/* perceba que podemos usar filtros nos selects normalmente */
select email, 'aluno' from aluno where sexo = 'f'
union
select email, 'professor' from professor where idprofessor in (2,4,6,8)
order by email;

/* OUTER JOIN UNION */
/* tras todos os registros das 2 tabelas em questao */
select
    *
from
    disciplina as d 
    left join professor as p on (d.fk_idprofessor = p.idprofessor)
union
select
    *
from
    disciplina as d 
    right join professor as p on (d.fk_idprofessor = p.idprofessor);




