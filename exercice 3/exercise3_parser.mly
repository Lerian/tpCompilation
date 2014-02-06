%{
  (** A map to store the variables associated with their value. *)
  let variables = Hashtbl.create 16
  
  (** Le fichier où on écrira au cours de l'exécution du programme *)
  let file = open_out "output_exercice3"
  
  (** Le nombre de variables créées *)
  let var_nbr = ref 0

  (**
    * Gets the value of the given variable from the map. Returns 0 if not found.
    *)
  let get_variable_value variable =
    try
      Hashtbl.find variables variable
    with Not_found ->
      begin 
        Error.not_initialized variable (symbol_start_pos ());
        0.
      end

  (**
    * Evaluates the given opeation with the given operands and stores the result
    * in the map for the given variable.
    *)
  let evaluate_operation var operand1 operation operand2 =
    let result = operation operand1 operand2 in
    if Hashtbl.mem variables var
      then
        begin
          Hashtbl.replace variables var result;
          Error.already_initialized var (symbol_start_pos ());
          result;
        end
      else
        begin
          Hashtbl.add variables var result;
          result
        end
   
%}

%token EOF
%token PLUS MINUS MUL DIV AFF
%token LPAR RPAR
%token <string> VAL

%start main
%type <unit> main

%%

main:
  expressions EOF {$1}
;

expressions:
    expression {output_string file $1}
  | expression expressions {}
;

expression:
		VAL {$1}
	|	expression PLUS expression {$1^"+"^$3}
	| expression MINUS expression {$1^"-"^$3}
	| expression MUL expression {$1^"*"^$3}
	|	expression DIV expression {$1^"/"^$3}
	| LPAR expression RPAR {$2}
;
