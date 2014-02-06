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

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> unit
