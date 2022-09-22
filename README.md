# Linux Adventures - Challenge 1

Provisioner script:

```sh
#!/bin/bash

set -e 

main()
{
   apt update && apt install -y git;
   cd /root
   git clone https://github.com/jdv-c2/linux-challenge-1.git;
   cd linux-challenge-1;
   chmod +x main.sh;
   bash main.sh;
}

main
```  

