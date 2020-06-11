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

create table gasto(
	idgasto int primary key auto_increment,
    ano int not null,
    tipo enum('previsto','realizado'),
    jan float(10,2),
    fev float(10,2),
    mar float(10,2),
    abr float(10,2),
    mai float(10,2),
    jun float(10,2),
    jul float(10,2),
    ago float(10,2),
    `set` float(10,2), /* No caso do set e do out, está dando erro porque coicidentemente 'set' e 'out' são palavras reservadas pelo mysql, nesse caso devemos usar o acrase para resolver esse problema */
    `out` float(10,2),
    nov float(10,2),
    dez float(10,2)
);

insert into gasto(ano, tipo, jan, fev, mar, abr, mai, jun, jul, ago, `set`, `out`, nov, dez)values('2019', 'previsto', 18000, 17000, 19000, 20000, 17000, 18000, 18500, 18500, 1800, 17500, 18000, 17000);
insert into gasto(ano, tipo, jan)values('2019', 'realizado', 18353.20);
update gasto set fev = 17555.55 where idgasto = 2;
update gasto set mar = 19435.73 where idgasto = 2;
update gasto set abr = 22753.12 where idgasto = 2;
update gasto set mai = 16198.12 where idgasto = 2;
update gasto set jun = 17451.88 where idgasto = 2;
update gasto set jul = 18975.40 where idgasto = 2;
update gasto set ago = 19163.84 where idgasto = 2;
update gasto set `set` = 18132.56 where idgasto = 2;
update gasto set `out` = 17667.91 where idgasto = 2;
update gasto set nov = 17936.33 where idgasto = 2;
update gasto set dez = 17125.88 where idgasto = 2;

/* Como podemos ver aqui em baixo nos tiramos a media de com a juncao de varias colunas */
/* Entao aqui podemos ver a interacao de calculo entre colunas e operacoes basicas de matematica */
select
	truncate(((jan + fev + mar + abr + mai + jun + jul + ago + `set` + `out` + nov + dez) / 12), 2) as media_meses /* Lembrando que o truncate retorna o numero de casas decimais para o numero que eu escolher */
from
	gasto
where
	tipo = 'realizado';


/* SUBQUERYS */
/* Vimos como fazer operações aritmeticas com varias colunas em 1 mesma linha, mas e se quisermos 
fazer as operações entre linhas diferentes, entre registros de linhas diferentes? Para isso usamos a subquery. */
/* Aqui podemos ver que temos que pegar primeiro a coluna que queremos e depois a linha que queremos. a interseccao das 2
é o item que sera escolhido no select */

select
	(select jan from gasto where idgasto = (select idgasto from gasto where ano = 2019 and tipo = 'previsto')) as previsto_jan,
	(select jan from gasto where idgasto = (select idgasto from gasto where ano = 2019 and tipo = 'realizado')) as realizado_jan;

/* para fazer subtracao, ex com varios */
select
	(select jan from gasto where idgasto = (select idgasto from gasto where ano = 2019 and tipo = 'previsto')) -
	(select jan from gasto where idgasto = (select idgasto from gasto where ano = 2019 and tipo = 'realizado')) as resultado_jan,
	(select fev from gasto where idgasto = (select idgasto from gasto where ano = 2019 and tipo = 'previsto')) -
	(select fev from gasto where idgasto = (select idgasto from gasto where ano = 2019 and tipo = 'realizado')) as resultado_fev;

/*DATAS*/

select curdate();  /* Data atual no formato: yyyy-mm-dd */
select current_date();  /* O mesmo do curdate */

select now() as data_hora;  /* Podemos colocar um alias normalmente */

/* Formatando data */
/*
%d - dia do mes
%D - dia do mes com sufixo ingles
%m - mes
%M - nome do mes em ingles
%y - ano dois digitos
%Y - ano quatro digitos
*/
select date_format(curdate(), '%D/%M/%y') as data_formatada; /* Coloca no formato pre estabelecido */
select extract(day from curdate()) as Extracao_data; /* Posso extrair o day, month ou year */

/* o date_add, nos permite adicionar second, minute, hour, day, month e year */
select date_add(current_date(), interval 6 day) as adicionando_data_dias;
select date_add(now(), interval 1 hour) as adicionando_data_horas;
select date_add('1995-12-31 10:15:20', interval 1 year) as adicionando_data_ano;
select now() as data_hora_atual, date_add(now(), interval -1 hour) as adicionando_data_horas;

/*datediff traz a diferença entre datas*/
select datediff(now(),'2000-09-09') as diferenca_em_dias; /*traz so em dias*/
select period_diff('200009','200007') as diferenca_em_meses; /*traz so em meses*/
select dayofyear('2019-09-09'); /*traz o dia do ano (0-365) da data colocada*/

select timestampdiff(year,'2018-05-10',curdate()) as diferenca_anos; /*traz a diferença de duas datas e pode ser em ano, aqui ele traz o exato, geralmente usado para calcular a idade (mais aconselhavel)*/

/* Aplicando na tabela aluno */
select * from aluno;
select timestampdiff(year, data_nascimento, curdate()) as idade_alunos from aluno;
alter table aluno drop column idade; /* Da para saber a idade dos alunos agora, nao preciso mais dessa coluna */

/* Da pra saber quem é o aniversariante do mes ou do dia */
/* no where ele primeiro ve se tem alguem fazendo niver no mesmo mes atual e depois no dia
Aqui o where nao vai retornar nada porque nao coloquei ninguem para fazer niver no dia da consulta (nem no mes)*/
select
    idaluno,
    nome,
    data_nascimento,
    extract(month from data_nascimento) as data_nascimento_mes,
	extract(day from data_nascimento) as data_nascimento_dia,
    
    curdate() as data_atual,
	extract(month from curdate()) as data_atual_mes,
	extract(day from curdate()) as data_atual_dia,
    timestampdiff(year, data_nascimento, curdate()) as idade
from
    aluno
where 
    extract(month from data_nascimento) = extract(month from curdate())
    and extract(day from data_nascimento) = extract(day from curdate());   