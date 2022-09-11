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
      system("cp -r " PATH ".exercises/* /home/tutor/;cat " PATH ".ascii/badge-1");      
      return(0);
   }
}
