%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <regex.h>

 
extern FILE *yyin;
extern FILE *yyout;
extern int line_number;
extern int yylineno;

regex_t regex;
regex_t regex1;
int reti;
char msgbuf[100];

int id_counter=0;
int id_buffer[5]={0,0,0,0,0};
int *ptr=id_buffer;
int a=0;

int id_counter1=0;
int id_buffer1[5]={0,0,0,0,0};
int *ptr1=id_buffer1;
int b=0;


int id_str_counter=0;
long intval=0;
int reti1;
char *strd;

int yylex();
void yyerror(char *s);
void remove_quotes(char *str);






%}

%union{
char *sval;
char *number_val; //mas voleuei na xeiristoume ta number tokens san strings
int integer_value;
}



%token NUMBER
%token STRING
%token true false null
%left O_BEGIN O_END A_BEGIN A_END
%left COMMA
%left COLON


%type <sval> programme array object STRING true false null elements pair value members 
%type <number_val> NUMBER

%locations
//%define parse.error verbose

%%





//GRAMMAR DEFINITION START---------------------------------------------------------------------------------------------------------
      /*
      tokens -> capital_letters
      non-terminal_variables -> small_letters
      */




programme : array   { 
               printf("%s",$1);
               free($1);
                    }

          |object  {
                    printf("\n\n\n\n%s\n\n\n\n",$1);
                    free($1);                   
                    }
;

array: A_BEGIN A_END{ 
                    $$ = (char *)malloc(sizeof(char)*10); 
                    sprintf($$,"[]");
                    }

       |A_BEGIN elements A_END{
                    $$ = (char *)malloc(sizeof(char)*(strlen($2)+10));
                    sprintf($$,"[%s]",$2); 
                    }
;

object : O_BEGIN O_END{ 
                      $$ = "{}";
                      }

          |O_BEGIN members O_END {
                                 $$ = (char *)malloc(sizeof(char)*(strlen($2)+10));                               
                                 sprintf($$,"{\n\t%s}",$2);
                                 }
;

// newline : '\n' {
//                line_number+=1; 
//                };



elements : value {
                 $$=$1;
                 }

          |value COMMA elements{
                              $$ = (char *)malloc(sizeof(char)*(strlen($1)+strlen($3)+10));
                              sprintf($$,"%s,%s",$1,$3);
                               }
;



members : pair {
               $$=$1;
               }

          | pair COMMA members { 
                               $$ = (char *)malloc(sizeof(char)*(strlen($1)+strlen($3)+10));
                               sprintf($$,"%s,%s",$1,$3);
                               }
;

pair : STRING COLON value{
                         $$ = (char *)malloc(sizeof(char)*(strlen($1)+strlen($3)+10));
                         //elegxos tou pediou text--------------------------------------------------------------------------------     
                         if(strcmp(($1),"\"text\"")==0){
                              if(strlen($3)>140){
                                   yyerror("The text field is invalid.");
                              }
                              else
                              {
                                   printf("\n\nThe text field is valid.\n\n");
                              }
                         }

                         //elegxos tou pediou id--------------------------------------------------------------------------------
                         if(strcmp(($1),"\"id\"")==0){
                              id_counter++;
                              *ptr=atoi($3);

                              if(id_counter >= 2){
                                        for(int i=0; i<id_counter-1; i++){     //check if the other fields exist(name,screen_name,location)!??
                                             if(id_buffer[i]==*ptr)
                                                  a++;
                                        }
                              }else{printf("\n\nThe id field is valid.\n\n");}
                         
                              if(a)
                                   yyerror("This id field allready exists.");
                              
                              ptr++;      
                         }
                          
                         //elegxos ean einai string ta pedia “name” “screen_name“location”--------------------------------------------------------------------------------
                         //gia to name
                         if(strcmp(($1),"\"name\"")==0){
                              isString($3,"name");
                         }
                         //gia to screen_name
                         if(strcmp(($1),"\"screen_name\"")==0){
                              isString($3,"screen_name");
                         }
                         //gia to location
                         if(strcmp(($1),"\"location\"")==0){
                              isString($3,"location");
                         }
                               
                         //elegxos tou pediou created_at--------------------------------------------------------------------------------
                         if(strcmp(($1),"\"created_at\"")==0){
                              //compile regex
                              reti = regcomp(&regex1,"(Mon|Tue|Wed|Thu|Fri|Sat|Sun)[ \n\t]*(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)[ \n\t]*([0-2][0-9]|3[01])[ \n\t]*(2[0-3]|[01][0-9]):[0-5][0-9]:[0-5][0-9][ \n\t]*\\+0000[ \n\t]*[[:digit:]]+", REG_EXTENDED); 
                              
                                 

                              //reti = regcomp(&regex1,"Thu Apr 06 15:24:15 +0000 2017", 0);

                              if (reti) {
                                   fprintf(stderr, "Could not compile regex\n");
                                   exit(1);
                              } 
                              //execute regex
                              reti = regexec(&regex1,$3, 0, NULL, 0);
                              if (!reti) {
                                   puts("\n\nThe created_at field is valid.\n\n");
                              }
                              else if (reti == REG_NOMATCH) {
                                   yyerror("The created_at field is invalid.");
                              }
                              else {
                                   regerror(reti, &regex1, msgbuf, sizeof(msgbuf));
                                   fprintf(stderr, "Regex match failed: %s\n", msgbuf);
                                   exit(1);
                              }
                              /* Free memory allocated to the pattern buffer by regcomp() */
                              regfree(&regex1);				  

  				     }

//-----------------------------------------------------------------------------------

                         if(strcmp(($1),"\"id_str\"")==0){
                              //elegxw ean exei ti domh pou 8elw me regex
                              reti1 = regcomp(&regex, "\"[[:digit:]]+\"", REG_EXTENDED);

                              /* Execute regular expression */
                              reti1 = regexec(&regex,$3, 0, NULL, 0);
                              if( !reti1 ){
                                   puts("\n\nThe id_str field is valid.\n\n");

                              //elegxw thn monadikothta
                                   id_counter1++;
                                   strd=strdup($3);
                                   remove_quotes(strd);
                                   *ptr1=*strd;

                              if(id_counter1 >= 2){
                                   for(int i=0; i<id_counter1-1; i++){
                                        if(id_buffer1[i]==*ptr1)
                                             b++;
                                   }
                              }
                                        
                              if(b)
                                   yyerror("The id_str field allready exists.");
                              ptr1++;
                              }
                              else if( reti1 == REG_NOMATCH ){
                                   yyerror("The id_str field is invalid.");
                              } 
                              else{
                                   regerror(reti1, &regex, msgbuf, sizeof(msgbuf));
                                   fprintf(stderr, "Regex match failed: %s\n", msgbuf);
                                   exit(1);
                              }

                              regfree(&regex);
                         }
                                 sprintf($$,"%s:%s",$1,$3); //h syntaktikh kathgoria pair pernei timh efoson ginei to reduction tou parapanw kanona
                         
                         }
       
      
value: STRING {
              $$=(char *)malloc(sizeof(char)*(strlen($1)+10));
              sprintf($$,"%s",yylval.sval);  //to string token pernei timh
              }

     | NUMBER {
              $$=(char *)malloc(sizeof(char)*(strlen($1)+10));
              sprintf($$,"%s",yylval.number_val); //to number token pernei timh
              }

     | object {
              $$=$1;
              }

     | array {
             $$=$1;
             }

     // | newline {
     //           $$=$1;
     //           }             

     | true {
            $$="true";
            }

     | false {
             $$="false";
             }

     | null {
            $$="null";
            }






%%
//GRAMMAR DEFINITION END---------------------------------------------------------------------------------------------------------



int yywrap()
{
   return 1;
}

int main(int argc, char **argv){

     

     ++argv; --argc;

     if(argc>0)
     yyin=fopen(argv[0], "r");
     else
     yyin=stdin;

     yyout=fopen("output","w");
     yyparse();
     printf("\n\n\n lines:%d\n",line_number-1);
     return 0;
}

void remove_quotes(char *str){
     int i,j;
     char *ptr;
     long intval;
     for(i=0,j=0; i<strlen(str); i++){
           if(str[i]!='\"')
           {
                str[j]=str[i];
                j++;
           }
     }str[j]='\0';
     intval=strtol(str,&ptr,10);
     //printf("%ld\n",intval);
}

void isString(char *str, char *field){
     int reti; 
     regex_t regex;

     reti = regcomp(&regex, "[[:alpha:]]+", REG_EXTENDED);

     /* Execute regular expression */
     reti = regexec(&regex,str, 0, NULL, 0);
     if( !reti ){
          printf("\n\nThe %s field is valid\n\n", field);
     }
     else if( reti == REG_NOMATCH ){
          char error_msg[100];
          strcpy(error_msg, "The ");
          strcat(error_msg, field);
          yyerror( strcat( error_msg," field is invalid.") );
     }
     else{
          regerror(reti, &regex, msgbuf, sizeof(msgbuf));
          fprintf(stderr, "Regex match failed: %s\n", msgbuf);
          exit(1);
     }

     regfree(&regex);
                                   
}



void yyerror(char *s){
     fprintf(stderr, "\n\n\nERROR : %s\n ", s );
     printf("The error occured near line %d\n\n\n", line_number);
     exit(1);
}
