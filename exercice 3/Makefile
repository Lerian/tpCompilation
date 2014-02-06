EXEC = exercise3

CAMLC = ocamlc
CAMLLEX = ocamllex
CAMLYACC = ocamlyacc

all:
	$(CAMLLEX) exercise3_lexer.mll
	$(CAMLYACC) exercise3_parser.mly
	$(CAMLC) -c error.ml
	$(CAMLC) -c exercise3_parser.mli
	$(CAMLC) -c exercise3_parser.ml
	$(CAMLC) -c exercise3_lexer.ml
	$(CAMLC) error.cmo exercise3_lexer.cmo exercise3_parser.cmo exercise3.ml -o $(EXEC)

clean:
	rm -f *.cm[iox] *.mli *~ .*~
	rm -rf exercise3_lexer.ml exercise3_parser.ml
