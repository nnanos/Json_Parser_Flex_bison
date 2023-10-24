=======================================================================
Json Parser with FLEX and BISON tools
=======================================================================

Description
============

This repository contains an implementation of a Json Parser. 
Json files are well known and used in a variety of applications.
These files have a specific format which is described **here**.
The parser implemented here is accomplished with the help of some old but good tools **flex** and **bison**.
Json format can be described by the below BNF syntactic definition of the grammar of the language. ::


<programme> ::= <array> | <object>
<array> ::= “[]” | “[” <elements> “]”
<elements> ::= <value> | <value> “,” <elements>
<object> ::= “{}” | “{” <members> “}”
<members> ::= <pair> | <pair> “,” <members>
<pair> ::= STRING “:” <value>
<value> ::= STRING | NUMBER | <objetct> | <array> | “true” | “false” | “null”


  **Note**: STRING and NUMBER are tokens that meet certain specifications
  (regular expressions) and which have been produced by the lectical analyzer (flex). The same applies
  for the rest of the terminal symbols which have been enclosed in double quotation marks.


So the parser with one pass of the input checks: 


 #. If the input is a syntactically correct json (satisfiying the above BNF grammar).

 #. If the input meets the bellow requierements.

 * The “text” element should be up to 140 characters.

 * The “user” element should contain a unique “id” as a positive
   integer, and “name”, “screen_name”, “location” as alphanumeric.

 * The “created_at” element should be in the format “Day_name MMM DD
   XX:XX:XX YYYY” where Day_name = Monday, Tuesday, etc., M = Month,
   D = Day, XX:XX:XX the timestamp format and Y = Year. For the timestamp
   make sure that a reasonable result is obtained ( hours 0 to 23 , minutes and
   seconds from 0 to 60 ).

 * The “id_str” element should be alphanumeric and UNIQUE,
   however contain only one positive integer, e.g. “19487012”,
   "8623490". 


============
Usage
=============

*SETUP




*EXAPLES


I now present some examples of execution.


              * Execution of the command: ::

                    ./tool.sh -f event.dat


                .. image:: /Images/1.png

                As you can see the desired functionality is achieved. The whole file as it is gets displayed.
              
              
              * Execution of the command: ::

                     ./tool.sh -f event.dat -id 1099511629352

                .. image:: /Images/2.png

                As you can see the desired functionality is achieved. The first name, last name, and date of birth of the user with the given id is displayed.

              
              * Execution of the command: ::

                     ./tool.sh --firstnames -f event.dat | head

                .. image:: /Images/3.png

                As you can see the desired functionality is achieved. All distinct first names (firstname field) contained in the file got displayed
                in alphabetical order. I just used head to print only the first few.


              * Execution of the command: ::

                     ./tool.sh --lastnames -f event.dat | head

                .. image:: /Images/4.png

                
                As you can see the desired functionality is achieved. All distinct Last names (Lastname field) contained in the file got displayed
                in alphabetical order. I just used head to print only the first few.
  

              * Execution of the command: ::

                     ./tool.sh --born-since 1989-12-03 --born-until 1990-01-09 -f event.dat | head

                .. image:: /Images/5.png


                As you can see the desired functionality is achieved. It prints only the rows that correspond to users born from
                date 1989-12-03 to date 1990-01-09.



              * Execution of the command: ::

                     ./tool.sh --socialmedia -f event.dat

                .. image:: /Images/6.png


                As you can see the desired functionality is achieved. The script 
                displays all social media used by users, in alphabetical order and its corresponding 
                number of users from the file that use it. 



              * Execution of the command: ::

                     ./tool.sh -f event.dat --edit 1099511629352 firstName NUNEZ


                .. image:: /Images/7.png


                As you can see the desired functionality is achieved. The script
                modifys the file for the user with code 1099511629352. It replaces the
                column **firstName** with value **NUNEZ**. 


============

Free software: MIT license
============
