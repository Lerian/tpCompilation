{
open Analyser_ex_2;;

  (** The line we are reading. *)
  let line_count = ref 1

  (** The character we are reading. *)
  let line_index = ref 1

  (** Tells wether we are going to read a new line. *)
  let new_line = ref true

  (** Moves the index to n characters. *)
  let move_index n = line_index := !line_index + n

  (** Returns a white space to separate tokens on the same line if necessary. *)
  let token_separator () = if !new_line then "" else " "

  (** Returns a line separator if necessary. *)
  let line_separator () = if !new_line then "" else "\n" 

  (** Prints a new line if necessary. *)
  let print_line () =
    if !new_line
      then ()
      else
        begin
          new_line := true;
          print_char '\n'
        end

  (** Prints the given simple token. *)
  let print_simple_token token =
    begin
      print_string ((token_separator ()) ^ token);
      new_line := false;
    end

  (** Prints the given valued token. *)
  let print_valued_token token_type token_value =
    begin
      Printf.printf "%s%s(%s)" (token_separator ()) token_type token_value;
      new_line := false;
    end

  (** Prints an error on a new line. *)
  let print_error line index character =
    begin
      Printf.printf "%sError line %d character %d: Unrecognized character '%c'\n"
        (line_separator ()) line index character;
      new_line := true;
    end
}

let digit = ['0'-'9']
let blank = [' ' '\t']
let number = digit+('.'digit+)?
let variable = ['a'-'z' 'A'-'Z' '_']['a'-'z' 'A'-'Z' '_' '0'-'9']*
let eol = ('\n' | "\r\n")

rule main = parse
  | "//" {new_line := false; comment lexbuf}
 
  | eol  {EOL; line_count := !line_count + 1; line_index := 1; print_line (); main lexbuf}
  | blank {move_index 1; main lexbuf} 

  | number as x   {NUM(float_of_string x); move_index (String.length x); main lexbuf}
  | variable as x {print_valued_token "VAR" x; move_index (String.length x); main lexbuf}

  | ":=" {AFF; move_index 2; main lexbuf}
  | '+'  {PLUS; move_index 1; main lexbuf}
  | '-'  {MINUS; move_index 1; main lexbuf}
  | '*'  {MUL; move_index 1; main lexbuf}
  | '/'  {DIV; move_index 1; main lexbuf}

  | eof {EOF}
  | _   as x {print_error !line_count !line_index x; move_index 1; main lexbuf}
  

and comment = parse
  | eol {line_count := !line_count + 1; line_index := 1; print_line (); main lexbuf}
  | eof  {print_line ()}
  | _    {comment lexbuf}
  

{
  (** The main function. *)
  let () =
    if Array.length Sys.argv < 2
      then print_endline "Please provide a file name" else
    let input_file = Sys.argv.(1) in
    if not (Sys.file_exists input_file)
      then print_endline "This file does not exist" else
    let lexbuf = Lexing.from_channel (open_in input_file) in
    main lexbuf
}
