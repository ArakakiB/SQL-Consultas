/* Conta, max, min, media e soma */
/* Vou continuar usando o DB do arquivo 2_1 */

use comandos_sql;

/* count */
/* Conta quantos tem com os parametros passados */
select * from aluno;
select count(*) from aluno;
select count(*) from aluno where sexo = 'F';
select count(distinct nome) from aluno;

/* max */
/* Valor max */
select max(valor_pago_curso) from aluno;
select max(valor_pago_curso) from aluno where idade > 40;
select max(valor_pago_curso) from aluno where idade < 40;

/* min */
/* Valor min */
select min(valor_pago_curso) from aluno;
select min(valor_pago_curso) from aluno where ativo_sn != 0;

/* avg */
/* Media */
select avg(valor_pago_curso) from aluno;
select avg(valor_pago_curso) from aluno where nome = 'Fulano';

/* sum */
/* Soma */
select sum(valor_pago_curso) from aluno;
select sum(valor_pago_curso) from aluno where nome = 'Fulano';

/* Traz varios de uma vez */
select 
	max(valor_pago_curso), 
    min(valor_pago_curso), 
    avg(valor_pago_curso), 
    sum(valor_pago_curso)  
from 
	aluno
where
	ativo_sn = 1;
    

/* Arredondamentos */
/* os 'as' Da nome a uma coluna */

/* ceil - arredonda o valor para cima */
/* Nesse caso qualquer valor acima de 0.01 arredonda para 1 */
select ceil(17.4) as valor;
select ceil(17.0) as valor;

/* floor - arredonda o valor para baixo */
select floor(19.555) as valor;

/* truncate - trunca a fração */
/* reduz a quantidade de casa decimal pelo numero escolhido, mas nao arredonda */
select truncate(22.757333, 1) as valor;
select truncate(12.0001, 1) as valor;

/* round - arredondamento */
/* < 5 = para baixo */
/* >= 5 = para cima */
/* 
0 1 2 3 4	5 6 7 8 9 
5 unidades para cada lado
*/
select round(55.752, 2) as valor;
select round(55.755, 2) as valor;
select round(55.759, 2) as valor;
select round(55.754, 2) as valor;
select round(55.744, 2) as valor;

select 
	nome, 
    ceil(valor_pago_curso) as valor 
from 
	aluno 
where 
	idaluno in(1, 4, 5);
    
    
select 
    round(avg(valor_pago_curso), 2) as valor_pago_curso 
from 
	aluno 
where 
	idaluno in(1, 4, 5);
    
    
/* GROUP BY */
/* Agrupa por determinado parametro */

select 
	nome, count(*) as repeticao_nome_agrupamento 
from 
	aluno 
group by 
	nome;
    
select 
	* 
from 
	aluno
group by
	ativo_sn;
	
    
select 
	ativo_sn, count(*) as repeticao_ativo_sn_agrupamento
from 
	aluno
group by
	ativo_sn;	

/* Vou colocar 2 pessoas com o mesmo nome para eu notar a diferenca no group by de baixo */    
update aluno set nome = 'Fulano' where nome = 'Sicrano';   

select 
	ativo_sn, nome, count(*) as repeticao_agrupamento
from 
	aluno
group by
	ativo_sn, nome;

select 
	ativo_sn, 
    round(avg(valor_pago_curso), 2) as media_por_agrupamento
from 
	aluno
group by
	ativo_sn;

select 
	sexo, floor(avg(idade)) as media_idade_por_sexo
from 
	aluno
group by
	sexo;
    
select 
	sexo, 
    min(idade) as menor_idade_do_agrupamento, 
    max(idade) as maior_idade_do_agrupamento
from 
	aluno
group by
	sexo;
    
select 
	estado, count(*) as total_por_estado
from 
	endereco
group by 
	estado;
    
select 
	tipo, count(*) as total_por_tipo
from 
	telefone
group by 
	tipo;
    

/* Misturando uns paranaues ai */
/* estados com mais alunos -  alunos por estado */
/* limit limita a quantidade de registros a aparecer */
select 
	estado, count(*) as total 
from 
	endereco
group by 
	estado
order by total desc
limit 3;
    
/* cursos mais vendidos - alunos por curso*/
select 
	fk_idcurso, count(*) as total
from 
	aluno_curso
group by
	fk_idcurso;