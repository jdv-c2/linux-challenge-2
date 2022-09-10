#!/usr/bin/env bash

# Provisioner script for first Linux adventures campaign
# Author: Johan de Vries 

set -e

main()
{  
   # Setup users
	tutor_pass="dHV0b3IK"
	jenny_pass="jenny123!"
	useradd tutor -m -s /bin/bash 2>/dev/null 
	useradd jenny -m -s /bin/bash 2>/dev/null
	echo "tutor:$tutor_pass" | chpasswd
   echo "jenny:$jenny_pass" | chpasswd
   
	useradd circus_c -m -s /bin/bash 2>/dev/null  
	useradd john -m -s /bin/bash 2>/dev/null
	useradd alice -m -s /bin/bash 2>/dev/null
	useradd bob -m -s /bin/bash 2>/dev/null

   # Application
   apt update && apt install -y gcc  
   
   # ---> Target 1 <---
   
   # Mission 1-2
   mkdir -p /home/tutor/dir1/dir2 2>/dev/null
   echo "cd /home/tutor/dir1/dir2/" >> /home/tutor/.bashrc
   mv tutor/instruction-1 /home/tutor/dir1/dir2/ReadMe
   mv tutor/instruction-2 /home/tutor/ReadMe
   chown -R tutor:tutor /home/tutor
   
   # Mission 3 
   mkdir -p /home/jenny/{Desktop,Documents,Downloads,Photos,Videos} 2>/dev/null

   # Add noise
   fnstr="/home/jenny/Photos/2022-" 
   for i in {1..34}; do
      cat /dev/urandom | tr -dc '[:graph:]' | fold -b80 | dd of=$fnstr$i.jpg bs=80 count=$(($RANDOM % 10 + 11)) &> /dev/null;
      printf "\n" >> $fnstr$i.jpg;
      touch -d "-8 hours" -d "-15 minutes" $fnstr$i.jpg; 
   done

   fnstr="/home/jenny/Videos/vacation" 
   for i in {1..7}; do
      cat /dev/urandom | tr -dc '[:graph:]' | fold -b80 | dd of=$fnstr$i.mp4 bs=80 count=$(($RANDOM % 10 + 101)) &> /dev/null;
      printf "\n" >> $fnstr$i.mp4;
      touch -d "-8 hours" -d "-15 minutes" $fnstr$i.mp4; 
   done
   
   fnstr="/home/jenny/Documents/report" 
   for i in {1..5}; do
      cat /dev/urandom | tr -dc '[:graph:]' | fold -b80 | dd of=$fnstr$i.xlsx bs=80 count=52 &> /dev/null;
      printf "\n" >> $fnstr$i.xlsx;
      touch -d "-$i days" -d "-2 hours"  -d "-12 minutes" $fnstr$i.xlsx; 
   done

   echo "Password: jenny123!" > /home/jenny/Desktop/.secret
   chown -R jenny:jenny /home/jenny
   
   # ---> Target 2 <---

   # Mission 1
   mv tutor/instruction-3 /ReadMe 
   chown tutor:tutor /ReadMe
   mkdir -p /mystery 2>/dev/null
   chown -R circus_c:circus_c /mystery
   chmod -R 750 /mystery

   # Mission 2
   echo "CIRCUS_INFECTED=true" >> /etc/lsb-release
   mv tutor/instruction-4 /etc/ReadMe 
   chown tutor:tutor /etc/ReadMe
   
   # Mission 3 and 4
   mv tutor/instruction-5 /bin/ReadMe 
   chown tutor:tutor /bin/ReadMe
   mv c/susp.c /tmp/susp.c
   gcc /tmp/susp.c -o /bin/suspicious
   chown jenny:jenny /tmp/susp.c
   chmod 700 /tmp/susp.c
   mv tutor/instruction-6 /tmp/ReadMe
   chown tutor:tutor /tmp/ReadMe
   
   # Adding some noise in the tmp folder
   # User Bob
   fnstr="/tmp/TMP4545" 
   for i in {1..5}; do
      cat /dev/urandom | tr -dc '[:graph:]' | fold -b80 | dd of=$fnstr$i bs=80 count=$(($RANDOM % 10 + 1)) &> /dev/null;
      printf "\n" >> $fnstr$i;
      touch -d "-$(($RANDOM % 5)) hours" -d "-$(($RANDOM % 60)) minutes" $fnstr$i; 
      chown bob:bob $fnstr$i; 
   done
   # User Alice
   fnstr="/tmp/report" 
   for i in {20..28}; do
      cat /dev/urandom | tr -dc '[:graph:]' | fold -b80 | dd of=$fnstr$i.xlsx bs=80 count=11 &> /dev/null;
      printf "\n" >> $fnstr$i.xlsx;
      touch -d "-2 hours"  -d "-$((2 * $i)) minutes" $fnstr$i.xlsx; 
      chown alice:alice $fnstr$i.xlsx;
   done
   # User John
   fnstr="/tmp/"
   for i in MSG VIDEO EDIT COMPOSE; do
      cat /dev/urandom | tr -dc '[:graph:]' | fold -b80 | dd of=$fnstr$i bs=80  count=$(($RANDOM % 10 + 11)) &> /dev/null;
      printf "\n" >> $fnstr$i;
      touch -d "-5 hours" -d "-12 minutes" $fnstr$i; 
      chown john:john $fnstr$i; 
   done
}

main
