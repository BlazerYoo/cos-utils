#!/usr/bin/bash
#################################################
# cos217_assignment_setup.sh                    #
#                                               #
# - Tool to set up your private GitHub repo for #
# COS217 assignments                            #
#################################################


# ANSI codes
ERROR='\033[41;1m'
INFO='\033[0;32m'
STD='\033[0;34m'
BANNER='\033[1;34m'
RESET='\033[0m'


# Banner
echo -e "${BANNER}  _  _   __ _     __    _   _  _   _     __  _ ___     _  "
echo " /  / \ (_   ) /|  /   |_) |_ |_) / \   (_  |_  | | | |_) "
echo -e " \_ \_/ __) /_  | /    | \ |_ |   \_/   __) |_  | |_| |   ${RESET}"
echo
echo


# Help
Help()
{
    # Display Help
    echo -e "${INFO}Set up your GitHub repositories to start working on COS217 assignments"
    echo
    echo "Please complete at least Setup Steps 1-3 in the GitGitHubPrimer.pdf document"
    echo "https://www.cs.princeton.edu/courses/archive/fall23/cos217/precepts/w01p1/GitGitHubPrimer.pdf"
    echo
    echo "usage: ./cos217_assignment_setup.sh username cos217-repo your-repo [option]"
    echo "options:"
    echo "-h     Print this Help."
    echo
    echo "example:"
    echo "./cos217_assignment_setup.sh BlazerYoo Decomment MyDecommentCode"
    echo
    echo "  This creates a copy of the https://github.com/COS217/Decomment"
    echo -e "  into BlazerYoo's new (private) repository https://github.com/BlazerYoo/MyDecommentCode${RESET}"
}


# Check for help flag
for arg in "$@"; do
    if [ "$arg" == "-h" ] || [ "$arg" == "--help" ]; then
        Help
        exit
    fi
done


# Main
# $1 - github username
# $2 - name of COS217 template repo
# $3 - name of your private github repo

# Check number of command line arguments
if [ $# -ne 3 ]; then
    echo -e "${ERROR}Error: Please provide exactly 3 command line arguments${RESET}"
    Help
    exit 1
fi

echo "Creating private repo '$3' based on '$2' for '$1'..."
echo
echo

# Bare clone template repo
git clone --bare https://github.com/COS217/$2

# Create private repo on github
curl -u $1 https://api.github.com/user/repos -d '{"name":"'"$3"'", "private":"true"}'

# Push template repo to your private repo
cd $2.git
git push --mirror https://github.com/$1/$3

# Clone private repo local machine
cd ..
git clone https://github.com/$1/$3


echo
echo
echo "Run cd $3 and get started."
echo
echo
echo "Created by Boaz '25"
echo