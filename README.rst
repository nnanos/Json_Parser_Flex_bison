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


#.

#.



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
