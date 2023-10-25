#!/bin/bash


flex Scanner.l
bison -d -g -t json_parser.y
gcc -g lex.yy.c json_parser.tab.c -o parser

