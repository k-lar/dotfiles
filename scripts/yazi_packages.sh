#!/bin/sh

# This script is used to install the required packages for Yazi.

# Check if yazi is installed
if ! command -v yazi &> /dev/null
then
    echo "yazi could not be found. Please install yazi first."
    exit
fi

# Check if ouch is installed
if ! command -v ouch &> /dev/null
then
    echo "ouch could not be found. Please install ouch first."
    exit
fi

# Github link: https://github.com/ndtoan96/ouch.yazi
ya pack -a ndtoan96/ouch
