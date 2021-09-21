#!/bin/bash

#Program: circumference_calculator
#Author: AJ Albrechts

#Delete some un-needed files
rm *.o
rm *.out

#"Assemble arithmetic.asm"
nasm -f elf64 -l circle.lis -o circle.o circle.asm

#Compile integerdriver.c"
gcc -c -Wall -m64 -no-pie -o egyptian.o egyptian.c -std=c11

#"Link the object files"
gcc -m64 -no-pie -o circumference_calculator.out -std=c11 circle.o egyptian.o

#"Run the program Integer Arithmetic:"
./circumference_calculator.out
