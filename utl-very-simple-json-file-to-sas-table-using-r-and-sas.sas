Very simple json file to sas table using r and sas

github
https://tinyurl.com/y7hmacvo
https://github.com/rogerjdeangelis/utl-very-simple-json-file-to-sas-table-using-r-and-sas

SAS Forum
https://tinyurl.com/yda7ss5x
https://communities.sas.com/t5/New-SAS-User/How-do-I-Read-Multiple-Delimited-Single-line-file/m-p/510809

Bill-SAS
https://communities.sas.com/t5/user/viewprofilepage/user-id/3480

   Two Solutions

      1. SAS/IML/R rio package
      2. SAS Json libname engine (fails because you dn't have SAS 9.4M4)

INPUT
=====

* code to load file;
filename ft15f001 "d:/json/simple.json";
parmcards4;
[{"seq":24425,"acc":"1-1951","Date":"26-08-2018"},
{"seq":24426,"acc":"1-1952","Date":"27-08-2018"},
{"seq":24427,"acc":"1-1953","Date":"28-08-2018"}]
;;;;
run;quit;

d:/json/simple.json

 [{"seq":24425,"acc":"1-1951","Date":"26-08-2018"},
 {"seq":24426,"acc":"1-1952","Date":"27-08-2018"},
 {"seq":24427,"acc":"1-1953","Date":"28-08-2018"}]

EXAMPLE OUTPUT
--------------

WORK.WANT total obs=3

   SEQ      ACC         DATE

  24425    1-1951    26-08-2018
  24426    1-1952    27-08-2018
  24427    1-1953    28-08-2018



PROCESS
=======

1. SAS/IML/R rio package
------------------------

   %utl_submit_r64('
     library(rio);
     library(SASxport);
     want<-import("d:/json/simple.json");
     write.xport(want,file="d:/xpt/want.xpt");
   ');

   libname xpt xport "d:/xpt/want.xpt";

   proc contents data=xpt._all_;
   run;quit;

   data want;
     set xpt.want;
   run;quit;

   proc print data=want;
   run;quit;


2. SAS Json libname engine (fails because you dn't have SAS 9.4M4)
------------------------------------------------------------------

   libname test json "d:/json/simple.json"
                 map="d:/json/simple.map" automap=reuse;
   run;

   proc print data=test.root(drop=ordinal_root);
   run;

   ERROR: The JSON engine cannot be found.




