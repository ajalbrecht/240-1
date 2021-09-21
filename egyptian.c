//****************************************************************************************************************************
//Program name: "circumference_calculator".  This program allow the user to calculate the circumference of a circle with most*
//integer values using the Egyptian value of pi (22/7).  Copyright (C) 2019 AJ Albrecht                                      *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
//version 3 as published by the Free Software Foundation.                                                                    *
//This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
//Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
//A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                          *
//****************************************************************************************************************************


//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//Author information
//  Author name: AJ Albrecht
//  Author email: ajalbrecht@fullerton.edu
//
//Program information
//  Program name: Integer Arithmetic
//  Programming languages: One modules in C and one module in X86
//  Date program began:     2020-Aug-30
//  Date program completed: 2020-Sep-22
//  Date comments upgraded: 2020-Sep-22
//  Files in this program: egyptian.c, circile.asm, r.sh
//  Status: Complete.  Tested with a dozen different inputs.  No error uncovered during that testing session.
//
//References for this program
//  Holiday, Integer Arithmetic, version 1.
//  Jorgensen, X86-64 Assembly Language Programming with Ubuntu, Version 1.1.40.
//
//Purpose
//  Compute the circumference of a circle
//
//This file
//   File name: egyptian.c
//   Language: C
//   Max page width: 132 columns
//   Compile: gcc -c -Wall -m64 -no-pie -o egyptian.o egyptian.c -std=c11
//   Link: gcc -m64 -no-pie -o circumference_calculator.out -std=c11 circle.o egyptian.o
//   Optimal print specification: 132 columns width, 7 points, monospace, 8½x11 paper
//
//
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//
//
//
//===== Begin code area ===========================================================================================================



#include <stdio.h>
#include <stdint.h>

long int circle();

int main () {
  //declare variable that stores the returned value
  long int result;

  //introduce the user to the program
  printf("%s\n", "Welcome to your friendly circle circumference calculator.");
  printf("%s\n", "The main program will now call the circle function.");

  //call the assembly function located in egyptian.c
  result = circle();

  //use the fresult from the assembly program to verify the assembly program can pass a number back to the main.
  printf("%s%ld\n", "The main received this integer: ", result);

  //inform the user that the program is about to end
  printf("%s\n", "Have a nice day. Main will now return 0 to the operating system.");
  return 0;
}
