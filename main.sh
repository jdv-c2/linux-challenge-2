#!/bin/bash

# Provisioner script for second Linux adventures campaign
# Author: Johan de Vries 

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
   apt update && apt install -y gcc figlet 
  
   # Create directory in /usr/share/
   advpath="/usr/share/.linux-adventures/"    
   mkdir -p $advpath.exercises 2> /dev/null 
   mkdir -p $advpath.exercises/dir-{1..3} 2> /dev/null 
   mkdir -p $advpath.ascii 2> /dev/null 
   mkdir -p $advpath.cron 2> /dev/null 
 
   # ---> Target 1 <---
   # Mission 1
   mv tutor/instruction-1 /home/tutor/ReadMe 
   mv tutor/exercise-1 /home/tutor/exercise-1.txt 
   echo "372C71E854C1394B599923E428FC5" > /home/tutor/this-is-your-key;
   chown -R tutor:tutor /home/tutor;
   chmod 400 /home/tutor/this-is-your-key;
   mv badge/badge-1 /usr/share/.linux-adventures/.ascii/badge-1
   gcc c/runme.c -o /bin/runme

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

   mv tutor/exercise-2 /usr/share/.linux-adventures/.exercises/exercise-2.txt
   mv badge/badge-2 /usr/share/.linux-adventures/.ascii/badge-2

   file_list=(file-{2,7,22,35,41}.txt)
   for i in {0..4};  
   do 
      sed -n $((1 + $i*4)),$((4 + $i * 4))p $advpath.ascii/badge-2 > $advpath.exercises/dir-1/${file_list[$i]};
   done 

   # Mission 3   
   mv tutor/exercise-3 /usr/share/.linux-adventures/.exercises/exercise-3.txt
   mv badge/badge-3 /usr/share/.linux-adventures/.ascii/badge-3

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
   mv tutor/exercise-4 /usr/share/.linux-adventures/.exercises/exercise-4.txt
   mv badge/badge-4  /usr/share/.linux-adventures/.ascii/badge-4 

   for i in {0..4};  
   do 
      sed -n $((1 + $i*4)),$((4 + $i * 4))p $advpath.ascii/badge-4 > $advpath.exercises/dir-1/file-$((1 + $i))0.txt;
   done 
  
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
   mv ascii/welcome /mystery/welcome.txt
   mv ascii/clown /usr/share/.linux-adventures/.ascii/clown

   for i in {1..40}; 
   do 
      sed -n ${i}p $advpath.ascii/clown > /mystery/box-0/part-${j[${i}]}.txt; 
   done 

   # Mission 2
   mv ascii/rabbit usr/share/.linux-adventures/.ascii/rabbit
    
   for i in {1..40}; 
   do 
      sed -n ${i}p $advpath.ascii/rabbit > /mystery/box-${i}/part-1.txt; 
   done 

   # Mission 3
   mv ascii/elephant /usr/share/.linux-adventures/.ascii/elephant

   for i in {1..40}; 
   do 
      sed -n ${i}p $advpath.ascii/elephant > /mystery/box-${i}/part-7.txt; 
   done 
  
   # Mission 4
   mkdir /mystery/.unlock;
   mv ascii/lock-closed /usr/share/.linux-adventures/.ascii/lock-closed

   for i in {1..40}; 
   do 
      sed -n ${i}p $advpath.ascii/lock-closed > /mystery/box-41/part-${j[${i}]}.txt; 
   done 
   
   mv ascii/lock-open /usr/share/.linux-adventures/.ascii/lock-open

   for i in {1..40}; 
   do 
      sed -n ${i}p $advpath.ascii/lock-open > /mystery/.unlock/part-${j[${i}]}.txt; 
   done 

   chown -R circus_c:circus_c /mystery;

   mv ascii/released-elephant /usr/share/.linux-adventures/.ascii/released-elephant

   gcc c/release-the-elephant.c -o /bin/release-the-elephant;
   chmod u+s /bin/release-the-elephant;
}

main
