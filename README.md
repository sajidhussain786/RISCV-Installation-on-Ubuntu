# RISCV-Installation-on-Ubuntu.
A shell script to install RISCV on Ubuntu 18.04, and Fedora
I have tested this script on Ubuntu 18.04 but hopefully it will work with all other linux versions 
***************************************************************************
This script will build/install the RISCV processor in the current directory.
 Execute this script in privilidge mode(sudo) because it will install many prerequsit software tools required to 
 build RISCV beside  cloning the relevant repsoitories. 
If it is not executing at host machine make it executable by running the following command in terminal.

$ sudo chmod 777 RISCV_install.sh    

to make is executable, or use  
$ chmod 744 RISCV_install.sh for current user only

IF your OS is Fedora please uncomment the requiered packeges installation command for Fedora and comment 
the Ubuntu's one below. follow the comments to get the right one.  
******************************************************************************

# Build and Run a C program on RISCV
To build and run a C program on RISCV please follow the istruction in file "Building and Running a program using RISCV" 
If it is not building your program check the PATH variable, does it contain path to your riscv-tools installation directory or not? if not then add the path then it will be able to properly locate the cross compiler required to generate the binary of riscv format plus other tools like spike required to run the program etc.
If it is not exporting the environment variable permanently and you have to add the path each time after you restart the system you can add simple shell file (xx.sh) into ect/profile.d/ containing the command to export variable and it will be executed automatically by the system each time when it starts.
