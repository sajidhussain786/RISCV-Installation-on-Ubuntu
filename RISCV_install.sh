#echo "<---**********************************************************************************************---> "
#"<---This script will build/install the RISCV processor in the current directory. ----> "
# "<---Execute this script in privilidge mode(sudo) because it will install many prerequsit software tools required to build RISCV beside cloning the relevant repsoitories. --> "
# "<---If it is not executing at host machine make it executable by running the following command in terminal. --> "
# "<--- sudo chmod 777 RISCV_install.sh ---> " # to make is executable, or use  chmod 744 for current user only
# "<---This script has been tested on ubuntu 18.04 but i beleive it works fine with other ubuntu and Fedora versions --> "
# "<---IF your OS is Fedora please uncomment the requiered packeges installation command for Fedora and comment the Ubunto's one below. follow the comments to get the right one. --> "
#echo "<---**********************************************************************************************---> "

echo "*" 
echo "*"  
echo "*" 
echo "<-------------------------------------------------------->"
echo "-  welcome to RISCV installing with SAJID HUSSAIN       -" 
echo "<-------------------------------------------------------->"
echo "*" 
echo "*"  
echo "*"  
echo "<--If you do not want to install it please press CLT+C immediately--->"
echo "On_Hold for 20 seconds"
sleep 20
echo "*"
echo "*"
echo " Ok Fine. Going to start installation"
echo "*"
echo "<-------------------checking updates --------------------->"
echo "<---***************************************************---> "
echo "*"
echo "*"
 
sudo apt-get update; #sudo apt-get upgrade 
sudo apt-get install git
echo "<----------------cloning FPGA-ZYNC resposiroty-------------------> "
git clone https://github.com/ucb-bar/fpga-zynq.git
cd fpga-zynq 
make init-submodules
echo "*"
echo "*"
echo "<---*****************************************************************---> "
echo "<-----------------Generating the Rocket-Chip----------------------------> "
echo "<---*****************************************************************---> "
echo "*"
echo "*"
    git clone https://github.com/ucb-bar/rocket-chip.git
    cd rocket-chip                       # Enter into rocket chip directory
    git submodule update --init

    #Installing rocket-chip tools
    echo "*"
    echo "*"
    echo "<---*************************************************************************************---> "
    echo "<---some pre-req tools are required for RISCV buidling & running: i.e. RISCV ToolChanin------>"
    echo "<---**************************************************************************************---> "
    echo "*"
    echo "*"
                echo "*"
                echo "*"
                 echo "<---*********************************************************************---> "
                echo "<---Installing some pre-requsit tools for required to build RISCV ToolChanin--->"
                echo "<---**********************************************************************---> "
                echo "*"
                echo "*"
                
                # Packages needed for ubuntu are following. plz comment/uncomment a line based on your OS.
                sudo apt-get install autoconf automake autotools-dev curl device-tree-compiler libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat1-dev pkg-config python python-dev

                #if  some pacakges failed to install due to some dependencies please install those pre-requsit packeges first. 

                #Fedora packages needed are following. plz comment/uncomment a line based on your OS. 
                #sudo dnf install autoconf automake @development-tools curl dtc libmpc-devel mpfr-devel gmp-devel libusb-devel gawk gcc-c++ bison flex texinfo gperf libtool patchutils bc zlib-devel python python-dev
                #if  some pacakges failed to install due to some dependencies please install those pre-requsit packeges first.
                
                echo "*"
                echo "*"
                 echo "<---*************************************************************---> "
                echo "<------------------- Chisel3 Installation----------------------------> " 
                echo "<---**************************************************************---> "
                echo "*"
                echo "*"
                sudo apt-get install default-jdk # 1 install JAVA
                # 2 Install sbt, which isn't available by default in the system package manager:
                echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
                sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823
                sudo apt-get update
                sudo apt-get install sbt
                echo "*"
                echo "*"
                 echo "<---***************************************************************---> "
                echo "<-------------------- Verilator Installation---------------------------> " 
                echo "<---****************************************************************---> "
                echo "*"
                echo "*"
                # Install Verilator. We currently recommend Verilator version 3.922. Follow these instructions to compile it from source.
                sudo apt-get install git make autoconf g++ flex bison # i. Install prerequisites (if not installed already):
                git clone http://git.veripool.org/git/verilator # ii. Clone the Verilator repository 
                cd verilator 
                git pull                     # ii In the Verilator repository directory, check out a known good version:
                git checkout verilator_3_922 
                # iv. In the Verilator repository directory, build and install:
                unset VERILATOR_ROOT # For bash, unsetenv for csh
                autoconf # Create ./configure script
                ./configure
                make
                sudo make install
                cd ..              ## come out of verilator directory
                echo "*"
                echo "*"
                 echo "<---*********************************************************************---> "
                 echo "<-----pre-requisit tools required for building Riscv tolls are installed here ----->" 
                 echo "<---************************************************************************---> "
            echo "*"
            echo "*"     
            echo "<---*********************************************************---> "
            echo "<------------- Now Building the Riscv-Toolchaing -------------> " 
            echo "<---- This will may take longer time(30 mint- 3hr depending the speed of your computer & internet)----> " 
            echo "<---*********************************************************---> "
            cd riscv-tools                            #Enter into riscv-directory
            git submodule update --init --recursive   # get latest one for git
            export RISCV=$(pwd)
	    export PATH=$PATH:$RISCV/bin
            echo "<---- RISCV variable will be pointed now to the following riscv-tools installation directory---> "
            echo $RISCV
            ./build.sh                                # build it
            #./build-rv32ima.sh  # incase (if you are using RV32).
            cd ..                                     # leave the directory, going back to rocket-chip directory
            echo "*"
            echo "*"
            echo "<---*********************************************************---> "
            echo "<----------------------CONGRATS---------------------------------> " 
            echo "<-------Riscv-toolchaing installation done here ---------------->" 
            echo "<---*********************************************************---> "
    echo "*"
    echo "*"
    echo "<---***********************************************************************---> "
    echo "<----------------NOW, First, going to build the C simulator------------------>" 
    echo "<---***********************************************************************---> "
    cd emulator
    make
    printenv >RISCV_Environment_variables #save environment variables in file for future use if not properly exported by export command. 
    # For me, export command was not adding variable permanently so i have to set RISCV and add it to PATH every time i restart the system. export RISCV=$(pwd)  export PATH=$PATH:$RISCV/bin
    echo "*"
    echo "*"
    echo "<---**********************************************************************---> "
    echo "<-------IF you want to install VCS simulator uncomment the following lines in script after installing VCS from synopsis-------->" 
    echo "<---**********************************************************************---> "
    #cd vsim
    #make
    echo "*"
    echo "*"
    echo "<---************************************************************---> "
    echo "<------------------Now Running Assembly tests ---------------------->"
    echo "<---*************************************************************---> " 
    make  run-asm-tests
    
    echo "*"
    echo "*"
    echo "<---**********************************************************************---> "
    echo "<---------------------Now Running Benchmarks tests tests --------------------->"
    echo "<---**********************************************************************---> "
    make  run-bmark-tests
    #To build a C simulator that is capable of VCD waveform generation:
    #cd emulator
    #make debug
    #And to run the assembly tests on the C simulator and generate waveforms (Assuming you have N cores on your host system):
    #make -jN run-asm-tests-debug
    #make -jN run-bmark-tests-debug
    #To generate FPGA- or VLSI-synthesizable Verilog (output will be in vsim/generated-src):
    # cd vsim
    # make verilog
    
    echo "*"
    echo "*"
    echo "<---***************************************************---> "
    echo "<--------------------Congratulations----------------------->"
    echo "<----------------------All DONE --------------------------->"
    echo "<---------------------------------------------------------->"
    echo "<---***************************************************---> "

