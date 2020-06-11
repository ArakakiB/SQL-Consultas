/* Explicacoes */
/* Esse arquivo é apenas informativo, nao executa querys */
/* --- Forma normal --- */
/* -- Regras da 1FN (primeira forma normal) */
/*
- Toda tabela necessita de pelo menos uma coluna que identifique os registros de forma unica (Primary key).
- As colunas devem possuir apenas valores atomicos
Campos multivalorados devem ser transformados em uma nova tabela
Campos compostos devem ser decompostos em colunas ou convertidos em outra tabela

Nas primary key temos a chave natural e a artificial
- Chave natural é quando você transforma uma coluna já existente (que faz parte do registro) na chave primaria. Essa chave está sujeita a alterações externas
- Chave artificial é quando você cria uma coluna especifica para ser sua chave primaria (eu sei muito como ID (identidade ou identificador)
O mais ideal é usar a artificial

Para dizermos para o SGBD que queremos a coluna como chave primaria é so adicionarmos "primary key" na criação da coluna ou modificação, logo apos definirmos o tipo de "variavel" 
a coluna seria (e depois da quantidade de caracteres se houver).
- Para a chave artificial teremos que criar uma coluna especifica (id), nesse caso devemos colocar o tipo "int" e colocar o auto_increment (que coloca sempre o numero seguinte do outro. Ex. 1, 2, 3, 4...)
Obs: o 'auto_increment' vai antes da 'primary key'

Valores atomicos: valores unicos que não sao divisiveis, Nesse caso ta nossa tabela atual, a unica coluna que nao é atomica é a do endereço, porque nele temos diversas informações que poderiam ser divididas.
No caso do nosso exemplo vamos decompor o endereço em novas colunas em logradouro, numero, complemento, bairro, cidade e estado.
Poderiamos tambem criar outra tabela, veremos isso mais para frente.
*/

/* Ex. de chave natural */
alter table aluno modify cpf varchar(14) primary key;

/* Ex. de chave artificial */
alter table aluno add idaluno int primary key auto_increment;


/* --- Cardinalidade de relaciamentos: 1:n 1:1 e n:n --- */
/* -- 1:n (ou 1 para muitos) */
/*
1 para muitos significa que a tabela principal tera 1 registro no qual terá outra tabela relacionada com muitos elementos
No nosso exemplo (baixei a figura "1 para n"), podemos observar que temos a tabela aluno com os numeros 1,1. O 1 da esquerda diz se o registro é obrigatório ou nao e o 1 da direita diz a quantidade de registro que teremos.
No caso da tabela aluno vamos ter 1 registro que vai conter a outra tabela (telefone), que por sua vez terá varios (muitos) registros (podendo ter nenhum tambem)
Ex.: Tabela Aluno (1,1) <- relacionado com -> Tabela telefone (0,n)
O 1 a esqueda da "Tabela aluno" diz se o registro é obrigatorio ou não. Nesse caso ele é.
O 1 a direita da "Tabela aluno" diz qual a quantidade de registro que estará relacionado da tabela aluno com a tabela telefone, nesse caso teremos apenas 1 registro.
O 0 a esqueda da "Tabela telefone" diz que não é obrigatorio existir um registro
O n a direita da "Tabela telefone" diz que podemos ter MUITOS registros nessa tabela que vão se relacionar com a "tabela aluno"
*/

/* Foreign Key pelo que entendi é a chave que dita o relacionamento entre tabelas. */
/* Obs: Foreign = Estrangeiro */

/*
No modelo logico devemos add o coluna da chave estrangeira (fk_idNOMETABELA), devemos add no formato int
Depois devemos no mesmo campo adicionar a tabela de relacinamento e colocar a tabela origem, a integridade referencial e as ligaçoes
*/

/*
Para fazer essa relação de cima no modo fisico:
constrant = nome da ligacao entre as 2 tabelas, nao uso esse nome em nehuma das 2
- alter table (tabela onde add a constrant, onde vamos colocar a chave estrangeira) 
- add constraint (nome da constrant, lembrando que é so um nome, mas por convensao usarmos o nome tabela que contem a chave primaria (estrangeira) depois
a o nome da tabela que vamos colocar a chave estrangeira com fk na frente. Ex: fk_NOMEDATABELADAORIGEMDAFOREIGNKEY_NOMEDATABELADESTINODAFOREIGNKEY) 
- foreign key (nome da chave primaria (estrangeira) que vai ficar na tabela que queremos colocar a chave estrangeira, 
lembrando que é so um nome, mas por convensao usarmos o nome do id da chave estrangeira com fk na frente. Ex.: fk_NOMEDAFOREIGNKEY) 
- references (Tabela de referencia, de onde to pegando esse id que quero colocar na minha tabela) (nome da chave primaria da tabela de referencia); 
*/
/* resumindo: add uma ligacao com o nome de fk_aluno_telefone, ou seja que vai de aluno para telefone, 
com a chave estrangeira chamada fk_idaluno, ou seja, o idaluno é a chave estrangeira 
e essa chave estrangeira é a coluna idaluno que vem da nossa tabela aluno 
Ex: */
alter table telefone add constraint fk_aluno_telefone foreign key (fk_idaluno) references aluno (idaluno);
/*
Depois disso podemos ver no desc aluno que a coluna fk_idaluno agora possui uma chave multipla (MUL)
Isso sig que nessa tabela essa fk pode se repetir.
*/


/*
Nos tambem podemos criar a constraint na criacao da tabela, mas nao é indicado porque nao criacao nao conseguimos dar um nome para ela
Ex: FOREIGN KEY (fk_idaluno) REFERENCES ALUNO (idaluno)
*/

/*
-- 1:1 (ou 1 para 1)
No caso vamos usar de cobaia nossa tabela 'Aluno' e vamos criar uma tabela 'Endereco'
Nessa situação como é 1:1 fica mais ou menos assim: 
Tabela aluno (1,1) <- relacinado com -> tabela endereco (1,1)
Nesse caso vamos ter obrigatoriedade nas 2 tabelas com o relacionamento 1 registro para 1 registro. 
Obs: Devemos colocar a constraint UNIQUE nos relacionamentos 1:1. Veja mais adiante o que é constraint e unique
*/

/*
-- n:n (ou muitos para muitos)
Esse caso é um pouco mais complicado. Baixei a imagem "Muitos para muitos"
Nesse caso vamos tentar colocar que 1 aluno faça parte de algum curso, porem se formos fazer um relacionamento convencional, veremos que quando formos relacionar nossa foreign key (chave estrangeira) em 1 curso, só consiguiremos colocar 1 aluno.
Pensando nesse obstaculo, deve-se ser feito o seguinte: Temos a tabela 'aluno' e 'curso', vamos criar a tabela "aluno_curso", onde relacionará a 'aluno' e 'curso'
Ex.: Vamos supor que o 'João' faça o 'Curso A' e a 'Maria' tambem. Fariamos:

Tabela aluno	Tabela aluno_curso		Tabela Curso
idaluno	Nome	idaluno	idcurso		idcurso	descricao
1	João	1	1		1	Curso A
2	Maria	2	1		2	Curso B

Nesse ex. acima podemos ver que tanto 'Maria' quanto 'João' fazem o 'Curso A'. Na imagem "Muitos para muitos" tem esse exemplo.
*/

/*
-- Tipo de dado ENUM (enumerados)
É um tipo que diz qual string ou int deve ser.
Ex.: No "tipo" do telefone, sabemos que nossas opções são "res, cel e com", mas se colocarmos um dado qualquer com 3 caracteres ele vai entrar, e nao é o que queremos. 
Então, nesse caso podemos usar o 'enum'.
Ex. ENUM (usando o "tipo" da tabela telefone): tipo enum('res', 'com', 'cel')
Assim dizemos que só aceitaremos os dados se forem "res, cel ou com".
*/

/*
- NULL e NOT NULL
Por convenção nossos registros de tabela aceitam um dado nulo (null), Se não quisermos que ele seja nulo devemos usar o NOT NULL
Ex.: alter table telefone modify column numero varchar(20) not null;
*/

/*
- Unique Constraint
Indica que os valores de uma determinada coluna devem ser unicos para todos os registros.
Ou seja: Os valores da coluna não podem se repetir.
Ex. de uso no create table: cpf varchar(14) unique,
Mas lembrando que é melhor nos adicionarmos o 'unique' a coluna atraver do alter table pois assim podemos dar um nome a constraint
Ex. alter table: alter table aluno add constraint uc_aluno_cpf unique(cpf);
add a constrant com o nome uc_aluno_cpf. uc = Unique Constraint e depois indica qual será a coluna no unique(cpf)
Obs: A coluna pode ser do tipo NULL no unique sem problemas.
*/

/*
- Constraint (restriçoes de integridade)
é uma regra de consistencia de dados que é garantida pelo proprio SGBD. Uma vez feita a constraint o porprio SGBD se encarrega dela evitando que seja quebrada
São constraints: Primary key, Foreign Key, Unique, Enum e Not null
*/