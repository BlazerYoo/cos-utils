#!/usr/bin/bash
#################################################
# cos217_compile.sh                             #
#                                               #
# - Tool to automatically preprocess, compile,  #
# assemble, and link C programs step by step    #
#################################################


# ANSI codes
ERROR='\033[41;1m'
INFO='\033[0;32m'
STD='\033[0;34m'
BANNER='\033[1;34m'
RESET='\033[0m'


# Banner
echo -e "${BANNER}  _  _   __ _     __    _  _        _ ___     _ "
echo " /  / \ (_   ) /|  /   /  / \ |\/| |_) |  |  |_ "
echo -e " \_ \_/ __) /_  | /    \_ \_/ |  | |  _|_ |_ |_ ${RESET}"
echo
echo


# Help
Help()
{
    # Display Help
    echo -e "${INFO}Preprocess, compile, assembly, and link C programs step by step in one line"
    echo
    echo "usage: ./cos217_compile.sh output  [option]"
    echo "options:"
    echo "-h     Print this Help."
    echo
    echo "example:"
    echo -e "./cos217_compile.sh hello-world hello-world.c${RESET}"
}


# Check for help flag
for arg in "$@"; do
    if [ "$arg" == "-h" ] || [ "$arg" == "--help" ]; then
        Help
        exit
    fi
done


# Main
# $1 - C file
# $2 - output name

# Check number of command line arguments
if [ $# -ne 2 ]; then
    echo -e "${ERROR}Error: Please provide exactly 2 command line arguments${RESET}"
    Help
    exit 1
fi

# Preprocess
gcc -E $1 > $2.i
if [ $? -ne 0 ]; then
    echo -e "${ERROR}Error: Could not preprocess${RESET}"
    exit 1
fi
echo -e "${INFO}Preprocessor created $2.i${RESET}"
echo -e "${STD}Press Enter to continue...${RESET}"
read -r

# Compile
gcc -S $2.i
if [ $? -ne 0 ]; then
    echo -e "${ERROR}Error: Could not compile${RESET}"
    exit 1
fi
echo -e "${INFO}Compiler created $2.s${RESET}"
echo -e "${STD}Press Enter to continue...${RESET}"
read -r

# Assembly
gcc -c $2.s
if [ $? -ne 0 ]; then
    echo -e "${ERROR}Error: Could not assemble${RESET}"
    exit 1
fi
echo -e "${INFO}Assembler created $2.o${RESET}"
echo -e "${STD}Press Enter to continue...${RESET}"
read -r

# Link
gcc $2.o -o $2
if [ $? -ne 0 ]; then
    echo -e "${ERROR}Error: Could not link${RESET}"
    exit 1
fi
echo -e "${INFO}Linker created $2${RESET}"
echo -e "${STD}Press Enter to continue...${RESET}"
read -r


echo
echo
echo "Done"
echo
echo
echo "Created by Boaz '25"
echo