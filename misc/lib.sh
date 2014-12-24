#!/usr/bin/env bash

#################################
# Set of helpers for bash scripts
# @author Victor Lopez
#################################

# Set some colors
RESET="\x1b[39;49;00m"
RED="\x1b[31;01m"
GREEN="\x1b[32;01m"
YELLOW="\x1b[33;01m"

function ok() {
    echo -e "${GREEN}[ok]${RESET} "$1
}

function warn() {
    echo -e "${YELLOW}[warn]${RESET} "$1
}

function error() {
    echo -e "${RED}[err]${RESET} "$1
}

function run() {
    echo -n -e "${GREEN} => ${RESET}" $1": "
}
