#!/bin/bash

# Provisioner script for second Linux adventures campaign
# Author: Jonathan Ben Ilan 

set -e

main()
{  
   # Setup users
	tutor_pass="dHV0b3IK"
	useradd tutor -m -s /bin/bash 2>/dev/null 
	echo "tutor:$tutor_pass" | chpasswd
	useradd circus_c -m -s /bin/bash 2>/dev/null  

   # Making mystery folder
   mkdir -p /mystery 2>/dev/null

   # Application
   # TODO remove purge of man-db 
   apt update && apt remove -y --purge man-db && apt install -y gcc  
  
   # Create directory in /usr/share/
   advpath="/usr/share/.linux-adventures/"    
   mkdir -p $advpath.exercises 2> /dev/null 
   mkdir -p $advpath.exercises/dir-{1..3} 2> /dev/null 
   mkdir -p $advpath.ascii 2> /dev/null 
   mkdir -p $advpath.cron 2> /dev/null 
 
   # ---> Target 1 <---

   # Mission 1
   cat << "EOF" > /home/tutor/ReadMe 

     #####
    #### _\_  ________
    ##=-[.].]| \      \ 
    #(    _\ |  |------|
     #   __| |  ||||||||    
      \  _/  |  ||||||||  Welcome back!
   .--'--'-. |  | ____ |  
  '   _     .|__|[o__o]|  Ready to learn more about Linux?
_{____nm_________/____\____ 

Today, you will get your second assignment as a cyber professional.

But first, I want you to practice a little with:
   - running commands on the command line
   - using wildcards
   - working with files and folders.
 
Read file exercise-1.txt to start your first exercise. 

After you have completed all five exercises, you are ready for 
today's assigment. Good luck!

EOF
   
   cat << "EOF" > /home/tutor/exercise-1.txt 
Every command on the command line has more or less the same
structure. It goes like this: 

COMMAND [OPTIONS] [ARGUMENTS]

The COMMAND is the name of the program.

OPTIONS are used to change or expand the command functionality.  
They typically start with a dash - (flags) or double dashes --. 

ARGUMENTS are typically filenames or other data that are feeded to the 
command (or to one of its options). 

On this machine, there is a command called 'runme'. 
Run the command and find out how it works. 

Your password is: "cyber123@#"

EOF

echo "372C71E854C1394B599923E428FC5" > /home/tutor/this-is-your-key;
chown -R tutor:tutor /home/tutor;
chmod 400 /home/tutor/this-is-your-key;

   cat << "EOF" > /usr/share/.linux-adventures/.ascii/badge-1
       _______________
      |####|     |####|    Congratulations!
      |####|  B  |####|
      |####|  A  |####|    You have been awarded the badge:
      {####|  D  |####}    
       {###|  G  |###}     --- command-runner --- 
        {##|  E  |##}
         .#|_____|#.
             (%)
          .-'''''-.         
        .'  * ` *  `.     
       :  *       *  :     
      : ~           ~ :    Now go on and complete the other
      : ~           ~ :    exercises in this directory...
       :  *       *  :
        `.  * . *  .`      
          `-.....-`                                 

Next exercise: ~/exercise-2.txt

EOF

    cat << "EOF" > runme.c
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define PATH "/usr/share/.linux-adventures/"

int system(const char *command);

int main(int argc, char *argv[])
{ 
   FILE *file; 
   char str[30];
   if (argc != 4 || strcmp(argv[1], "-p") || !(file = fopen(argv[3], "r"))) {
      printf("Usage: %s -p password keyfile\n", argv[0]); 
      return(1);
   } else if (strcmp(argv[2], "cyber123@#")) {
      printf("Wrong password. Please try again.\n");
      return(2);
   } else if (fgets(str,30,file) == NULL || str == "372C71E854C1394B599923E428FC5") {
      printf("Wrong keyfile. Please try again.\n");  
      return(3);
   } else {
      system("cp -r " PATH ".exercises/* .;cat " PATH ".ascii/badge-1");      
      return(0);
   }
}
EOF

   gcc runme.c -o /bin/runme

   # Mission 2  

   # Creating noise
   fnstr="$advpath.exercises/dir-1/file-" 
   for i in {1..50}; do
      cat /dev/urandom | tr -dc '[:graph:]' | fold -b80 | dd of=$fnstr$i.txt bs=80 count=4 &> /dev/null;
      printf "\n" >> $fnstr$i.txt;
   done

   for i in {10..50..10}; do
      cat /dev/urandom | tr -dc '[:graph:]' | fold -b80 | dd of=$fnstr${i}0.txt bs=80 count=4 &> /dev/null;
      printf "\n" >> $fnstr${i}0.txt;
   done

   cat << "EOF" > /usr/share/.linux-adventures/.exercises/exercise-2.txt

  #####
 #### _\_  
 ##=-[.].]
 #(    _\ 
  #   __|     Great work! Here is your next exercise.
   \  _/    
.--'--'-.    

As you know, the 'cat' command lets you display the contents of a file.
But it can also output the contents of multiple files at once.
That's why the name of the command is taken from the word 'concatenate'.

The cat command can take in multiple arguments. Let's see how it works.

Cat out the following files from dir-1: 
   - file-2.txt
   - file-7.txt
   - file-22.txt
   - file-35.txt
   - file-41.txt

But do it in one command, with multiple arguments.

EOF

   cat << "EOF" > /usr/share/.linux-adventures/.ascii/badge-2
       _______________
      |####|     |####|    Congratulations!
      |####|  B  |####|
      |####|  A  |####|    You have been awarded the badge:
      {####|  D  |####}              +     +  
       {###|  G  |###}               |  c  | 
        {##|  E  |##}                |  a  |
         .#|_____|#.                 |  t  |
          .-'''''-.                  |  -  |
        .'  - ` -  `.                |  m  | 
       :  -       -  :               |  a  |
      : ~           ~ :              |  s  | 
      : ~           ~ :              |  t  | 
       :  *       *  :               |  e  |
        `.  * . *  .`                |  r  | 
          `-.....-`                  +     +


Next exercise: ~/exercise-3.txt

EOF

   file_list=(file-{2,7,22,35,41}.txt)
   for i in {0..4};  
   do 
      sed -n $((1 + $i*4)),$((4 + $i * 4))p $advpath.ascii/badge-2 > $advpath.exercises/dir-1/${file_list[$i]};
   done 

   # Mission 3   
   cat << "EOF" > /usr/share/.linux-adventures/.exercises/exercise-3.txt

  #####
 #### _\_  
 ##=-[.].]
 #(    _\ 
  #   __|     Amazing! Ready for exercise 3?
   \  _/    
.--'--'-.    

The 'cat' command can receive a lot of arguments to concatenate files.
Likewise, many other commands on the CLI can take in more than one file. 

But writing down long lists of arguments can sometimes be tedious.

That's why Linux has powerfull wildcards that saves you time typing.     
They are called 'globs'. 

Let's start with the most powerfull of them.

The * wildcard is a placeholder for: "any character any number of times". 
That's basically saying "match me everything". 

Let's try it! Cat out "all the files" from dir-2.  

Use the * to accomplish this fast. Good luck!

EOF

   cat << "EOF" > /usr/share/.linux-adventures/.ascii/badge-3
                                                  .. 
      --- Twinkle, Twinkle                       .##. 
                                                .####%                   
                   Linux Star ---               $#####'                  
                                               ?#######^                 
                                     :%%%%%%%%#########&%%%%%%%%?        
                                     ^##########################%.       
                                       }%####################&$~         
                                 .~}$%^  ^%&################?:           
                             :'%%&#####%^  ^###############.             
                         :'$#&##########^  }###############'             
                     .~}%&#############}  ~#######&#&#######.            
                  .'$##################  .######$'. :?%&####$            
               .'$####################%  :%&#$'.       :?%&&%            
             ^%#####################&%~    ..             ..             
          .}%######################}:                                    
        :}#######################?.                          
      :%&#####################&}.                            
    :%&######################%:     Congratulations!                                        
  .}&######################%~                                                               
 '#######################&?         You have been awarded the badge:                        
?#####%#################%:                                                     
~%%}^  '##############&}            _______________                                         
     :$##############%^            |####|     |####|     +     +                                   
    }###############%              |####|  B  |####|     |  r  |                  
  :%##############&'               |####|  A  |####|     |  i  |                        
  :%##%%$$########^                {####|  D  |####}     |  s  |                        
          :#####$.                  {###|  G  |###}      |  i  |  
          ^&###}                     {##|  E  |##}       |  n  |
          $###}                       .#|_____|#.        |  g  |
         .###'                         .-'''''-.         |  -  |
          :^.                        .'  - ` -  `.       |  s  |
           .                        :  -       -  :      |  t  |
                                   : ~           ~ :     |  a  |
                                   : ~           ~ :     |  r  |
                                    :  *       *  :      |     |
                                     `.  * . *  .`       +     +
                                       `-.....-`                 
Next exercise: ~/exercise-4.txt

EOF

   # This creates an alphabetically ordered list of numbers 
   j=({0..40});  
   IFS=$'\n'; 
   j=($(sort <<<"${j[*]}")); 
   unset IFS; 
   
   for i in {1..40}; 
   do 
      sed -n ${i}p $advpath.ascii/badge-3 > $advpath.exercises/dir-2/file-${j[${i}]}.txt; 
   done 
  
   # Mission 4
   cat << "EOF" > /usr/share/.linux-adventures/.exercises/exercise-4.txt
   
  #####
 #### _\_  
 ##=-[.].]
 #(    _\ 
  #   __|     Good progress! Here is exercise 4.
   \  _/    
.--'--'-.    

There are also one-character wildcards to match filenames:
   - The ? (question mark) matches any character but only one time.
   - The [ ] (square brackets) matches a range of characters one time.
     For example: m[a,o,u]m matches mam, mom, mum 
     or a range:  car-[1-4] matches car-1, car-2, car-3 and car-4.   

Go ahead! Cat out each tenth file from dir-1. 
  - file-10.txt
  - file-20.txt
  - file-30.txt
  - file-40.txt
  - file-50.txt

Use one-character wildcards to accomplish this fast. Good luck! 

EOF

   cat << "EOF" > /usr/share/.linux-adventures/.ascii/badge-4 
       _______________
      |####|     |####|    Congratulations!
      |####|  B  |####|
      |####|  A  |####|    You have been awarded the badge:
      {####|  D  |####}                
       {###|  G  |###}        --- globbing-               
        {##|  E  |##}                     wizard --- 
         .#|_____|#.                 
          .-'''''-.                  
        .'  - ` -  `.                
       :  -       -  :               
      : ~           ~ :              
      : ~           ~ :              
       :  *       *  :               
        `.  * . *  .`                
          `-.....-`                  


Next exercise: ~/exercise-5.txt

EOF

   for i in {0..4};  
   do 
      sed -n $((1 + $i*4)),$((4 + $i * 4))p $advpath.ascii/badge-4 > $advpath.exercises/dir-1/file-$((1 + $i))0.txt;
   done 
   
   # Mission 5 and 6
   mkdir $advpath.exercises/dir-3/{delete-me,rename-me} 2> /dev/null;
   echo "Copy me into sandbox" >>  $advpath.exercises/dir-3/copy-me;

   cat << "EOF" > /usr/share/.linux-adventures/.exercises/exercise-5.txt 
   
     #####
    #### _\_  ________
    ##=-[.].]| \      \ 
    #(    _\ |  |------|
     #   __| |  ||||||||    
      \  _/  |  ||||||||  Almost there!
   .--'--'-. |  | ____ |  
  '   _     .|__|[o__o]|  This is your last exercise for today. 
_{____nm_________/____\____ 

The { } (curly braces) are not globbing wildcards for pattern matching, 
but are used to create patterns. This is also called "brace expansion".
The command line will "expand" the given range "as if typed" on the cli.  
   - c{a,e,u}t wil become: cat cet cut
   - cmd-{1..4} will become: cmd-1 cmd-2 cmd-3 cmd-4

This can be useful for creating multiple files (or other objects) at once
and saves you a lot of time!

Let's try it when working with files and folders. 

Accomplish the following tasks in dir-3:
   - Remove the directory delete-me
   - Rename the directory rename-me to sandbox
   - Copy the file copy-me to sandbox (without renaming)
   - In sandbox create dir-1, dir-2 ... until dir-50   
   - In each directory create file-1.txt, file-2.txt ... until file-5.txt 

Be very careful to name the objects exactly as above (including the 
dashes -). Use brace expansion to accomplish the last two tasks fast.

When you have finished all the tasks in dir-3, you'll get your fifth badge
and you assigment: ~/assignment.txt

EOF

   cat << "EOF" > /usr/share/.linux-adventures/.ascii/assignment.txt 
   
     #####
    #### _\_  ________
    ##=-[.].]| \      \ 
    #(    _\ |  |------|
     #   __| |  ||||||||    
      \  _/  |  ||||||||  Amazing!
   .--'--'-. |  | ____ |  
  '   _     .|__|[o__o]|  You have received all badges.. 
_{____nm_________/____\____ 

Now it is time for your next assignment...

As we know, our filesystem was infected by malware, causing strange
artifacts to be found on our filesystem.

Our threat intelligence department has identified the hacker group
known as: "Circus Cyber". This is a notorious group of script kiddies 
targeting filesystems mainly for fun. If you solve their riddles, you
can remove the malicious objects from the filesystem.. 

Their first riddle can be found in the directory /mystery that they 
have placed at the root of the filesystem. 

We have granted you access to the /mystery directory in order to solve 
the mystery and remove the directory from our filesystem.

Your ticketnumber: d8dcc2235 

Good luck! 

EOF

   cat << "EOF" > /usr/share/.linux-adventures/.ascii/badge-5 
       _______________
      |####|     |####|    Congratulations!
      |####|  B  |####|
      |####|  A  |####|    You have been awarded the badge:
      {####|  D  |####}                
       {###|  G  |###}        --- sandbox-warrior ---               
        {##|  E  |##}                      
         .#|_____|#.                 
          .-'''''-.                  
        .'  - ` -  `.                
       :  -       -  :               
      : ~           ~ :              
      : ~           ~ :              
       :  *       *  :               
        `.  * . *  .`                
          `-.....-`                  


Read your assignment: ~/assignment.txt

EOF
   
   cat << "EOF" > /usr/share/.linux-adventures/.cron/mission-5.sh
str="/home/tutor/dir-3/";

check_task5(){
   arr=(${str}sandbox/*/*)
   arr_c=(${str}sandbox/dir-{1..50}/file-{1..5}.txt)
   IFS=$'\n'; 
   arr_c=($(sort <<<"${arr_c[*]}"));
   unset IFS;
   if [ "${arr[*]}" == "${arr_c[*]}" ]; then
       cp /usr/share/.linux-adventures/.ascii/badge-5 /home/tutor; 
       cp /usr/share/.linux-adventures/.ascii/assignment.txt /home/tutor; 
   fi
}

check_task4(){
   arr=(${str}sandbox/*)
   arr_c=(${str}sandbox/{copy-me,dir-{1..50}});  
   # Sort array in place
   IFS=$'\n'; 
   arr_c=($(sort <<<"${arr_c[*]}"));
   unset IFS;
   if [ "${arr[*]}" == "${arr_c[*]}" ]; then
       check_task5; 
   fi
}

check_task123() {
   if [ ! -d ${str}delete-me ] && [ -d ${str}sandbox ]  && [ ! -d ${str}rename-me ]  && [ -f ${str}sandbox/copy-me ] ; then
      check_task4;
   fi
}

if [ ! -f ${str}badge-5 ]; then 
   check_task123; 
fi
EOF

   cat << "EOF" >> /usr/share/.linux-adventures/.cron/mission-5-root.sh 
str="/home/tutor/dir-3/";

if [ ! -f ${str}badge-5 ]; then 
   chmod 775 /mystery;     
fi
EOF

   echo "* * * * *   tutor /bin/bash /usr/share/.linux-adventures/.cron/mission-5.sh" > /etc/cron.d/mission-5;
   echo "* * * * *   root /bin/bash /usr/share/.linux-adventures/.cron/mission-5-root.sh" >> /etc/cron.d/mission-5;

   # ---> Target 2 <---
   mkdir -p /mystery/box-{0..41} 2> /dev/null;   

   # Creating noise
   
   for i in {0..41}; do
      for k in {1..40}; do 
         cat /dev/urandom | tr -dc '[:graph:]' | fold -b80 | dd of=/mystery/box-${i}/part-${k}.txt bs=80 count=4 &> /dev/null;
         printf "\n" >> /mystery/box-$i/part-${k}.txt;
      done
   done

   # Mission 1
   cat << "EOF" >> /mystery/welcome.txt


                                                ..                             
   Welcome to Circus Glob!           %##########&%.                            
                                     ##########%      Circus                         
     Ready to solve our mystery?     %###########}.      Glob                   
                                    '#?:.:::::::^^.                            
                                 .%&####~                                      
                               '###&%%####$:                                   
                            :$##&$%}~#:%$%###}                                 
                         .}&##%~?&$ %#:.&#~}&##%^                              
                       ~%##&?.^##% .##% .&#$.:%##&%.                           
                    :$###%^ :###?  ?###   ###}  }&###}.                        
                 .}&##&?  .%###}   &###'   ####}  :%###%~                      
              .?####%:  .$####~   :#####    %###&'   }####%^                   
           .}#####}.   }#####^    $#####.    %#####^   :$###&%^                
        .}#####$:    }&#####:     ######%     $######:    '####&$^             
     .?######'     ~&#####&.     '######&      }######%.    :$&###&%~          
    .######%      ~#######}      %#######:      &######&      .######$         
    .######%      '#######'      %#######.      &######&      .######%         
     %######:    .#########.    ^&#######%     '########?     %#####&:         
      .^######%%#############%%#############%%&##########&%%#&####}:           
        ##########################################################^            
        &#########################################################}            
       .############################? &############################            
       }###########################%  :###########################&            
       %##########################&    }###########################^           
      .###########################:     %##########################$           
      }##########################?       &#########################&           
      ##########################%        .##########################'          
     ^#########################%          ^#########################&          
     #########################}            .%########################~         
    ~######################&}                ^%######################&         
    &####################%^                    .'%&###################%        
                                                                                  
   Our jugglers have accidentally mixed up all our boxes. 

   You can only find one of our clowns in box-0. He has an important message
   for you! Output "all the parts" from box-0 to meet the clown.        

EOF

   cat << "EOF" > /usr/share/.linux-adventures/.ascii/clown
             

                                                         
                           .^'?}?~.                                        
                         '####&&###&}                                      
                       .###$:.  .^%##&:                                    
                    ..:##&:        .##&':::::.                             
                ~%&######'     ..:^~$##########&$^                         
              ^###%?%####%%##&#######&&####:.^?####.                       
           .:?###. .&####&#%$%?'^:..   :%&#&~   :&##'.                     
        ^$&###&%    ?##&}?}?^        :??}~%##%.  .######%:                 
      :####?^.     '###$&?^~%#.     %#'^'#%~&#&.    .^}###%.               
     .&#&:        ^##%}##$%$$&#    %#%$%$%#%.&#&.       '###               
     :##%         ##&.##  ~&###~  .#}  }&#&# ^##%        ###.              
      ##&.       '##?.#?  %####%  ^#^ .#####^ %##^      ^##%               
      :##&.      ###.:#~?&#####%  }#:%######} :##%     ^##&.               
      ?##&:      &## ^#~ ^}}}^##  ?#..~?}'^#}  &#&     ~##&'               
    .###}       .### .#%%$$$$%%}  ~#$$$$$$%#~  ###.      %##$              
    %##^       ~###}         ~%&##&%}.         %###^      }##}             
   .##%       $##$.        .###%??$##&^         :###'      &#&             
   .&#&.     }##?          }##?    :###           &##.    ^###             
    ^##&~   .##&           ^###^..:%##}           }##}   ?##&.             
     .%##&%:}##$  ^^.       ^########'       :~^  :##%^$###%               
       .}######} ^####$':.     :~~^.    .^?%&###  ^######}.                
          .^}##&: .?&#####&#%%?'~~'}%%#&######^  .###}^.                   
             ^&##}   %###%%%#&&####&&#%%###&'   ^&##}                      
              .%###^  :###%            %##%.  .%###^                       
                ^####~  '##&}        }##&~  ^%##&}                         
                  :%###%..}##&%^..:}&##%..?&###~                           
                    .'###&?~}########%~}###&}.                             
                       .}###&######%#&##&%:                                
                           ^?%#&&&&#%%~.                        

   Hi there, my name is: "Echo the Clown" 

   We have enough clowns, but we've lost our elephant.
   You'll have to find the elephant!!

   Output "part-1.txt from box-1 until box-40" to ask for help. 

EOF

   for i in {1..40}; 
   do 
      sed -n ${i}p $advpath.ascii/clown > /mystery/box-0/part-${j[${i}]}.txt; 
   done 

   # Mission 2
   cat << "EOF" > /usr/share/.linux-adventures/.ascii/rabbit
                 ..                       .                  
                %#$'.                  ~%#$                 
               :&####?.             .?#####:                
               ^#######'           ~#######~                
               :&#######}         ?########^                
                %########}       ?#########                 
                }#########~     ^#########?                 
                 %########%     %#########.                 
                 :########&}.~.{&########^                  
                  :#####################^                   
                   .%#################$:                    
                    ~################&:                     
                   ~&#################%.                    
                  }&###$$#########$$####^                   
                .$####{ }#########{ }####}                  
                }##########&%$%###########^                 
                }########%###^###%&#######^                 
                .%#######{{${~}$}}&######}                  
                 .?#######&#&#&#&#####&%~                   
                    .~?}}}}%%#%%}?}?}~.                     
                                                            
              . .:^~'{{?{{%%%%%%%}}?}}'~^:..:               
           .~?$%#&#######################&#%$}~.            
          :########%}'~^^:::...:::^^~'}$########:           
          .}#&######%%$$%{{{???}}}%$$%%######&#}.           
             :~}}%#######################%}?~:              
                 '#######################}                  
                 ?#######################}                  
                 %#######################%                  
                :&########################^                 
                %#########################$                 
               .%#&#####################&#%:                
                 .:^~'{?{{%%%%%%%%}?}}~^:.                  
                                                            
   Rabbit: "Hi there, are looking for the elephant???   
            I've witnessed the poor fellow being kidnapped.
            You may find him if you combine one of the
            other parts from box-1 until box-40. Hurry!"            

EOF
    
   for i in {1..40}; 
   do 
      sed -n ${i}p $advpath.ascii/rabbit > /mystery/box-${i}/part-1.txt; 
   done 

   # Mission 3
   cat << "EOF" > /usr/share/.linux-adventures/.ascii/elephant
 

.______________________________________________________________________________.    
._____. .__________. .__________. .__________. .__________. .__________. ._____.   
     .| |         .| |          | |          | |          | |.         | |.        
     .| |       ..^| |~~~~~~~~~~| |~~~~^:.   | |   ^?%$$}'| |          | |.        
     .| |  .~?$%#&#| |##########| |#####&##%$| | ^########| |$$$$%}:   | |.        
     .| |}%&#######| |##########| |##########| |~&########| |#######%. | |.        
     .| |##########| |##########| |##########| |?%}}}}}}}}| |}}}}}}}%~ | |.        
     ?| |##########| |##########| |#########&| |}}}}}}}}}}| |}}}}}}}}}%| |.        
    %#| |##########| |##########| |#########%| |##########| |##########| |.        
   }##| |##########| |##########| |##########| |%%#&######| |##########| |.        
   %##| |##########| |##########| |##########| |$?'''?%%#&| |%#########| |}        
   %##| |##########| |##########| |##########| |###&#%%?}}| |##########| |#.       
   %##| |##########| |##########| |##########| |#########&| |##########| |#^       
   %#&| |##########| |##########| |##########| |#######%::| |###&######| |#.       
   %##| |##########| |##########| |##########| |#######~  | |....^$####| |?        
   %##| |##########| |##########| |##########| |######&.  | |     .&###| |.        
   %##| |?#########| |##########| |##########| |######&:  | |     ^####| |.        
 .?##}| |.&########| |##########| |###&######| |%#####&:  | |     '####| |.        
.%&%'.| |:&######?%| |%%%%##%%%%| |}'^^######| |%#####&:  | |     }####| |.        
 ..  .| |:&#####%  | |%}}?.     | |   .######| |?%%%%%}:  | |     }%%%'| |..       
     .| |:&#####% .| |###&.     | |   .######| |}}?????:  | |     }}}'.| |##%      
     .| |:&#####% .| |###&.     | |   .######| |%#####&:  | |     '&###| |#&'      
     .| |:&#####% .| |###&.     | |   .######| |%#####&:  | |      .}$%| |?.       
     .| |:&#####% .| |###&.     | |   .&#####| |%#####&:  ~.~.         | |.        
     .| | $####&? .| |###$      | |    %#####| |?&####$ '$$}$$}.       | |.        
_____:| |__~?}?^__:| |}?~_______. ._____~?}?~| ..^}}?~.?#~. .:$%._____.| |.____    
_______________________________________________________%%:. .:}&^______________    
                                                     :#&&&&##&&#&}                 
                                                     :####%'%####?                 
                                                     :#####~$####?                 
                                                     .$%%%###%%%%'                 

   Please help me! The kidnappers are almost leaving. 

   You can find the lock if you output "all the parts from box-41". 
    
   Hurry up, time is running out! 

EOF

   for i in {1..40}; 
   do 
      sed -n ${i}p $advpath.ascii/elephant > /mystery/box-${i}/part-7.txt; 
   done 
  
   # Mission 4
   mkdir /mystery/.unlock;

   cat << "EOF" > /usr/share/.linux-adventures/.ascii/lock-closed




                         ........
                    .~?%$%%%%%%%%$%?~.
                  ~%%################%%~
                ^$#####%}}'~~~~'}}%#####$^
               '%####}^            ^}#####~
              :%###%~                ~%###%:
              {####}                  ?####}
              ?####~                  ~####?
              ?####~                  ~####?
              ?####~                  ~####}
            ..?####'.::::::::::::::::.'####?..
          '%%%#####%%%%%%%%%%%%%%%%%%%%#####%%%'
        .$######################################$.
        '########################################'
        '########################################'
        '########################################'
        '################%?~^^~?%################'
        '###############%^      ^%###############'
        '###############%.      .%###############'
        '################%~    '%################'
        '#################$    %#################'
        '#################$    $#################'
        '#################%'::'%#################'
        '########################################'
        '########################################'
        .%######################################%.
          ~{$################################$}~
            :~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~:

                  {{LOCK CODE: 000000}}
            
   Oh oh! The lock to release the elephant is not open.
   There is a hidden directory in /mystery. 
   Try to open the lock by copying all the files from
   that hidden directory into box-41. 

EOF

   for i in {1..40}; 
   do 
      sed -n ${i}p $advpath.ascii/lock-closed > /mystery/box-41/part-${j[${i}]}.txt; 
   done 
   
   cat << "EOF" > /usr/share/.linux-adventures/.ascii/lock-open

                        ..::::::::..
                     :{{$%%%%%%%%%%}}?:.
                  .^{###################}^
                 ^%####%{'~^^::^^~'}%#####}.
                ~#####$~             ~$####$.
               .%####'                 '####%.
               ~####?                  .%###%.
               ~####?                  .%###%.
               ~####?                  .%###%.
               ~####?                  .$%%%$.
               ~####?                   ~~~~~
               ~####?
               ~####?
               '####?
           :}%$%####%%%%%%%%%%%%%%%%%%%%%%%%%%$}'.
          }######################################%^
         ^########################################$
         ~########################################%.
         ~########################################%.
         ~#################%?}'}%%################%.
         ~################?.     :%###############%.
         ~################^       }###############%.
         ~################$^    .}%###############%.
         ~#################%:   }#################%.
         ~#################%:   }#################%.
         ~##################~  .}#################%.
         ~###################%$%##################%.
         ~########################################%
         .%#######################################?
          .?%##################################%$'
            .:~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~:.

                  {{LOCK CODE: 348731}}


   You have opened the lock! 
   If you have copied it all to box-41, run the command: release-the-elephant


EOF

   for i in {1..40}; 
   do 
      sed -n ${i}p $advpath.ascii/lock-open > /mystery/.unlock/part-${j[${i}]}.txt; 
   done 

   chown -R circus_c:circus_c /mystery;

   cat << "EOF" > /usr/share/.linux-adventures/.ascii/released-elephant

                                                                                



               .:^'}}??????????????????}~^.      .'$%##%}~.                     
           :}%%#&#########################&#%%%.:###############%%~             
        :?%###################################}:###################%            
      .%&####################################':#####################%.          
     ~######################################'.########################^         
    ^&######################################'.########################&'        
    %#######################################&%~'}}$#&######&############}       
   .&##########################################&#$}}''?%$%}~$############^      
   .&#################################################%%$$%##############%      
   .&##################################################%%&###############$      
   .&#%###############################################$  .'?}}}%%########'      
   .&#?^##############################################~          ?######$       
   .&#? .$####################################&&######^          ~#####%.       
   ^##}   }##################################?.}######^          ?#####:        
 :$&#%    }########&&&##########&&##%%%######^ }######^          $###&^         
 :}?^     }#####&: ~}}}}}}''~~~^:..   '######~ }######^          %###'          
          }#####&: }##&&&#.           '######~ }######^         .###?   ~}?.    
          }#####&: }#####&:           '######~ }######^          %##%'~%##&^    
          }#####&: }#####&:           '######~ }######^          .}######$^     
          }######: }#####&:           '######~ }######^             :^^:.       
          }######. }######.           ~######^ ~#####&:                         
           '$%%%^   '$%%}^             ~%%%%~   ~$%%%^                          
                                                                                
  
   Wow! 
   You have freed me from my kidnappers and you have save Circus Glob!!
   Thank you so much. 

   Circus Glob is leaving town to our next destination. You can safely
   remove the mystery folder. 
   
   If you want to visit our circus again, here is your lifelong VIP-ticket
   --- circus-glob-468 ---
   
   Goodbye! You can safely remove the /mystery directory. We are gone.   
                                                                                
EOF

   cat << "EOF" > release-the-elephant.c
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int system(const char *command);

int main(int argc, char *argv[])
{ 
   FILE *file; 
   char str[30];
   if (argc != 3 || strcmp(argv[1], "-l"))  {
      printf("Usage: %s -l lockcode\n", argv[0]); 
   } else if (strcmp(argv[2], "348731")) {
      printf("Wrong lockcode. Please try again.\n");
   } else {
      system("cat /usr/share/.linux-adventures/.ascii/released-elephant; chmod 777 /mystery");      
   }
}
EOF

   gcc release-the-elephant.c -o /bin/release-the-elephant;
   chmod u+s /bin/release-the-elephant;
}

main