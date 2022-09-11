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
      setuid(0);
      system("cat /usr/share/.linux-adventures/.ascii/released-elephant; rm -rf /mystery; cd /");      
   }
}
