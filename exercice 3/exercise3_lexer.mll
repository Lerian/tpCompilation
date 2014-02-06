{
  open Exercise3_parser

  (** Increments the lexing buffer line number counter.*)
  let increment_linenum lexbuf =
    let pos = lexbuf.Lexing.lex_curr_p in
    lexbuf.Lexing.lex_curr_p <-
      {pos with Lexing.pos_lnum = pos.Lexing.pos_lnum + 1; Lexing.pos_bol = 0}
  
  (** Increments the lexing buffer line offset by the given length. *)
  let increment_bol lexbuf length =
    let pos = lexbuf.Lexing.lex_curr_p in
    lexbuf.Lexing.lex_curr_p <- {pos with Lexing.pos_bol = pos.Lexing.pos_bol + length}

}

let blank = [' ' '\t' '\r']
let number = ['0'-'9']+('.'['0'-'9']+)?
let variable = ['a'-'z' 'A'-'Z' '_']['a'-'z' 'A'-'Z' '_' '0'-'9']*

rule main = parse
  | "//" {comment lexbuf}
 
  | '\n'  {increment_linenum lexbuf; main lexbuf}
  | blank {increment_bol lexbuf 1; main lexbuf} 

  | number as x   {increment_bol lexbuf (String.length x); VAL x}

  | ":=" {increment_bol lexbuf 2; AFF}
  | '+'  {increment_bol lexbuf 1; PLUS}
  | '-'  {increment_bol lexbuf 1; MINUS}
  | '*'  {increment_bol lexbuf 1; MUL}
  | '/'  {increment_bol lexbuf 1; DIV}
  
  | '('	 {increment_bol lexbuf 1; LPAR}
  | ')'	 {increment_bol lexbuf 1; RPAR}

  | eof {EOF}
  | _   as x {Error.unrecognized_char lexbuf.Lexing.lex_curr_p x; increment_bol lexbuf 1; main lexbuf}
  

and comment = parse
  | '\n' {increment_linenum lexbuf; main lexbuf}
  | eof  {EOF}
  | _    {comment lexbuf}

{}
