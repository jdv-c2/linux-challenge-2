#!/usr/bin/env bash

# Provisioner script for first Linux adventures campaign
# Author: Jonathan Ben Ilan 

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
   
   # Mission 1
   mkdir -p /home/tutor/dir1/dir2 2>/dev/null
   echo "cd /home/tutor/dir1/dir2/" >> /home/tutor/.bashrc
   mv ~/instruction-1 /home/tutor/dir1/dir2/ReadMe

   # Mission 2
   cat << EOF > /home/tutor/ReadMe

  #####
 #### _\_  
 ##=-[.].]
 #(    _\ 
  #   __|  Amazing!
   \  _/    
.--'--'-.  You are at the start of my home folder (~)  

The home folder is where a user spends most of his time.
On desktop versions, you can find in here folders like: 
'Desktop', 'Documents', 'Downloads', 'Photos' and 'Videos'.

Are you ready for your first mission as a cyber professional?

Strange things are happening on this filesystem.  
We suspect it all started with a password leak of one of
our employees: Jenny.

Can you investigate her home folder (navigate to ~jenny)? 

Good luck! Your ticket number is: 1ebd987c7

EOF
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

   cat << EOF > /ReadMe 

  #####
 #### _\_  
 ##=-[.].]
 #(    _\ 
  #   __|  You are getting good at this!
   \  _/    
.--'--'-.    

You are now at the very root of the Linux file system. 
Everything starts from here.

From here you can find important machine folders like:
/bin, /boot, /etc, /home, /mnt, /proc, /root and /tmp

Read about the Filesystem Hierarchy Standard (FHS) online.
There is one directory that doesn't belong here.

What is the name of this directory? 

EOF
   chown tutor:tutor /ReadMe
   mkdir -p /mystery 2>/dev/null
   chown -R circus_c:circus_c /mystery

   # Mission 2

   echo "CIRCUS_INFECTED=true" >> /etc/lsb-release
   cat << EOF > /etc/ReadMe 

     #####
    #### _\_  ________
    ##=-[.].]| \      \ 
    #(    _\ |  |------|
     #   __| |  ||||||||    
      \  _/  |  ||||||||      
   .--'--'-. |  | ____ |     We are in the /etc directory!
  '   _     .|__|[o__o]|     
_{____nm_________/____\____ 

In /etc you typically find machine configuration files.

Examples of machine configurations are: network interfaces,
dns configuration, user and groups, scheduled tasks and more.

In this directory you can also find important variables set.
For example you can find values on the distribution in 
the file: lsb-release. 

As you can see, the release of our machine is Ubuntu 18.04 
with codename: bionic.   

The attackers have added their own variable to the 
lsb-release file: CIRCUS_INFECTED.   

What value is set for this variable?

EOF

   chown tutor:tutor /etc/ReadMe
   
   # Mission 3 and 4

   cat << EOF > /bin/ReadMe 

  #####
 #### _\_  
 ##=-[.].]
 #(    _\ 
  #   __|   Excellent!
   \  _/    
.--'--'-.   You are in the /bin directory. 

Here you can find binary files. 
These are typically executable programs.

In the /bin folder you can find programs like: 
'pwd', 'ls', and 'cat'.

On our customer machine we see a binary with a 
very very "suspicious" name

Run this suspicious program!

EOF
   chown tutor:tutor /bin/ReadMe

   cat << EOF > /tmp/susp.c
# include <stdio.h>

int main()
{
   printf("circus started...\n");
   return(0);
}
EOF

   gcc /tmp/susp.c -o /bin/suspicious
   chown jenny:jenny /tmp/susp.c
   chmod 700 /tmp/susp.c

   cat << EOF > /tmp/ReadMe

     #####
    #### _\_  ________
    ##=-[.].]| \      \
    #(    _\ |  |------|
     #   __| |  ||||||||    
      \  _/  |  ||||||||  Great, you are in /tmp!     
   .--'--'-. |  | ____ |  
  '   _     .|__|[o__o]|  Let's investigate this place.
_{____nm_________/____\____ 

The /tmp directory is a place where all users can create 
temporary files and that is usually cleared at boot time.

It is a common place for attackers to place malicious code.

Remember Jenny whose account was maybe compromised? 

Can you find a file, owned by Jenny, with source code 
of our suspicious program?

What is the name of this file?

EOF
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
