{
  let line_count = ref 0;;
  
  let new_line () =
  	line_count := !line_count + 1;
  	print_newline ();;
}

let blank = [' ' '\t' '\r']
let number = ['0'-'9']+('.'?['0'-'9']+)?
let variable = (['a'-'z' 'A'-'Z' '_']+['0'-'9']*)+

rule token = parse
  | "//" {comment lexbuf}
 
  | '\n' {new_line (); token lexbuf}
  | blank {token lexbuf} 

  | number as n   {print_string ("VAL("^n^") "); token lexbuf}
  | variable as v {print_string ("VAR("^v^") "); token lexbuf}
  
  | '+' {print_string "PLUS "; token lexbuf}
  | '-' {print_string "MINUS "; token lexbuf}
  | '*' {print_string "MUL "; token lexbuf}
  | '/' {print_string "DIV "; token lexbuf}
  | ":=" {print_string "AFF "; token lexbuf}

  | eof {}
  | _ as c {print_endline ("\nError line "^string_of_int(!line_count)^" character"^string_of_int(Lexing.lexeme_start lexbuf)^": '"^Char.escaped(c)^"'"); token lexbuf}
  

and comment = parse
  | '\n' {new_line (); token lexbuf}
  | eof {}
  | _ {comment lexbuf}
  

{
  let _ =
    if Array.length Sys.argv < 2
      then print_endline "Please provide a file name" else
    let input_file = Sys.argv.(1) in
    if not (Sys.file_exists input_file)
      then print_endline "This file does not exist" else
    let lexbuf = Lexing.from_channel (open_in input_file) in
    token lexbuf;;
}
