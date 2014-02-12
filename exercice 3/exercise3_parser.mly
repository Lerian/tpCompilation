%{
  (** A map to store the variables associated with their value. *)
  let variables = Hashtbl.create 16
  
  (** Le fichier où on écrira au cours de l'exécution du programme *)
  let file = open_out "output_exercice3"
  
  (** L'indice de la prochaine variable créée *)
  let var_nbr = ref 1

	(**
		* Affiche une expression donnée
		*
	let display_expression express =
		begin
			output_string file (get_variable_name express);
			output_string file " := ";
			output_string file express;
   		output_string file "\n";
   	end*)
  
  (**
  	* Retourne le nom de la variable associée à une expression donnée dans la map
  	* Ajoute l'expression à la map si elle n'y figure pas
  	* Affiche l'expression en cas d'ajout
  	*)
  let get_variable_name express =
  	if Hashtbl.mem variables express
      then
      	begin
	        Hashtbl.find variables express
				end
      else
        begin
          Hashtbl.add variables express ("x"^(string_of_int !var_nbr));
          output_string file ("x"^(string_of_int !var_nbr));
					output_string file " := ";
					output_string file express;
			 		output_string file "\n";
          incr var_nbr;
          Hashtbl.find variables express
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
    expression {}
  | expression expressions {}
;

expression:
		VAL {$1}
	|	expression PLUS expression {get_variable_name ($1^"+"^$3)}
	| expression MINUS expression {get_variable_name ($1^"-"^$3)}
	| expression MUL expression {get_variable_name ($1^"*"^$3)}
	|	expression DIV expression {get_variable_name ($1^"/"^$3)}
	| LPAR expression RPAR {$2}
;
