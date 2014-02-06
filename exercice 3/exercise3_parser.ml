type token =
  | EOF
  | PLUS
  | MINUS
  | MUL
  | DIV
  | AFF
  | LPAR
  | RPAR
  | VAL of (string)

open Parsing;;
# 2 "exercise3_parser.mly"
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
   
# 55 "exercise3_parser.ml"
let yytransl_const = [|
    0 (* EOF *);
  257 (* PLUS *);
  258 (* MINUS *);
  259 (* MUL *);
  260 (* DIV *);
  261 (* AFF *);
  262 (* LPAR *);
  263 (* RPAR *);
    0|]

let yytransl_block = [|
  264 (* VAL *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\003\000\003\000\003\000\003\000\003\000\
\003\000\000\000"

let yylen = "\002\000\
\002\000\001\000\002\000\001\000\003\000\003\000\003\000\003\000\
\003\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\004\000\010\000\000\000\000\000\000\000\
\001\000\000\000\000\000\000\000\000\000\003\000\009\000\000\000\
\000\000\000\000\000\000"

let yydgoto = "\002\000\
\005\000\006\000\007\000"

let yysindex = "\005\000\
\250\254\000\000\250\254\000\000\000\000\003\000\015\255\023\255\
\000\000\250\254\250\254\250\254\250\254\000\000\000\000\030\255\
\030\255\030\255\030\255"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\008\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\001\000\
\004\000\007\000\010\000"

let yygindex = "\000\000\
\000\000\013\000\002\000"

let yytablesize = 274
let yytable = "\003\000\
\005\000\004\000\009\000\006\000\008\000\001\000\007\000\002\000\
\000\000\008\000\000\000\016\000\017\000\018\000\019\000\010\000\
\011\000\012\000\013\000\014\000\003\000\000\000\004\000\010\000\
\011\000\012\000\013\000\000\000\000\000\015\000\010\000\011\000\
\012\000\013\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\005\000\005\000\
\005\000\006\000\006\000\006\000\007\000\007\000\007\000\008\000\
\008\000\008\000"

let yycheck = "\006\001\
\000\000\008\001\000\000\000\000\003\000\001\000\000\000\000\000\
\255\255\000\000\255\255\010\000\011\000\012\000\013\000\001\001\
\002\001\003\001\004\001\007\000\006\001\255\255\008\001\001\001\
\002\001\003\001\004\001\255\255\255\255\007\001\001\001\002\001\
\003\001\004\001\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\006\001\007\001\
\008\001\006\001\007\001\008\001\006\001\007\001\008\001\006\001\
\007\001\008\001"

let yynames_const = "\
  EOF\000\
  PLUS\000\
  MINUS\000\
  MUL\000\
  DIV\000\
  AFF\000\
  LPAR\000\
  RPAR\000\
  "

let yynames_block = "\
  VAL\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'expressions) in
    Obj.repr(
# 55 "exercise3_parser.mly"
                  (_1)
# 197 "exercise3_parser.ml"
               : unit))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 59 "exercise3_parser.mly"
               (output_string file _1)
# 204 "exercise3_parser.ml"
               : 'expressions))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'expression) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expressions) in
    Obj.repr(
# 60 "exercise3_parser.mly"
                           ()
# 212 "exercise3_parser.ml"
               : 'expressions))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 64 "exercise3_parser.mly"
      (_1)
# 219 "exercise3_parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 65 "exercise3_parser.mly"
                              (_1^"+"^_3)
# 227 "exercise3_parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 66 "exercise3_parser.mly"
                               (_1^"-"^_3)
# 235 "exercise3_parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 67 "exercise3_parser.mly"
                             (_1^"*"^_3)
# 243 "exercise3_parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 68 "exercise3_parser.mly"
                             (_1^"/"^_3)
# 251 "exercise3_parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expression) in
    Obj.repr(
# 69 "exercise3_parser.mly"
                        (_2)
# 258 "exercise3_parser.ml"
               : 'expression))
(* Entry main *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let main (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : unit)
