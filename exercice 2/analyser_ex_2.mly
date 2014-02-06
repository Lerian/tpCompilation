%{

	(** création d'une map pour stocker les variables **)
	module VariableMap = Map.Make(String)
	let variables = ref VariableMap.empty
	
	(** ajout d'un élément à la map **)
	let variable_addition variable value =
		variables := VariableMap.add !variable !value variables
		
	(** recherche d'un élément dans une map **)
	let find_variable_value variable =
		VariableMap.find !variable variables

%}

%token AFF

%token PLUS
%token MINUS
%token MUL
%token DIV

%token EOL
%token EOF

%token <float> VAR
%token <float> NUM

%start main
%type <Functions.t_modules> main

%%

main:
	lines EOF {$1}
;

lines:
	line EOL {$1}
;

line:
	var AFF formule {$1}
;

formule:
	value operation value {$2 $1 $3}
;

value:
	NUM {$1}
	| VAR {$1}
;

operation:
	PLUS {(+.)}
	| MINUS {(-.)}
	| MUL {( *. )}
	| DIV {(/.)}
;

%%
