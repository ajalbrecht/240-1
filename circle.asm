;*****************************************************************************************************************************
;Program name: "circumference_calculator".  This program allow the user to calculate the circumference of a circle with most*
;integer values using the Egyptian value of pi (22/7).  Copyright (C) 2019 AJ Albrecht                                      *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
;version 3 as published by the Free Software Foundation.                                                                    *
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
;Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
;A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
;*****************************************************************************************************************************

;=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;Author information
;  Author name: AJ Albrecht
;  Author email: ajalbrecht@fullerton.edu
;
;Program information
;  Program name: circumference_calculator
;  Programming languages: One modules in C and one module in X86
;  Date program began:     2020-Aug-30
;  Date program completed: 2012-Sep-22
;  Date comments upgraded: 2020-Sep-22
;  Files in this program: egyptian.c, circile.asm, r.sh
;  Status: Complete.
;
;References for this program
;  Holiday, Integer Arithmetic, version 1.
;  Jorgensen, X86-64 Assembly Language Programming with Ubuntu, Version 1.1.40.
;
;Purpose
;  Compute the circumference of a circle
;
;This file
;   File name: circle.asm
;   Language: X86-64 with Intel syntax
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l circle.lis -o circle.o circle.asm
;   Link: gcc -m64 -no-pie -o circumference_calculator.out -std=c11 circle.o egyptian.o
;   Optimal print specification: 132 columns width, 7 points, monospace, 8½x11 paper



;Declare the names of programs called from this X86 source file, but whose own source code is not in this file.
extern printf                                     ;Reference: Jorgensen book 1.1.40, page48
extern scanf

global circle

segment .data                                     ;Initialized data are placed in this segment

;.data portions of code
welcome db "This circle function is brought to you by AJ", 10, 0
stringoutputformat db "%s", 0 ; writes
promptforinteger db "Please enter the radius of a circle in whole number of meters: " , 0
signedintegerinputformat db "%ld",0 ; inputs
userresponse db "The number %ld was received.", 10, 0
calculation1 db "The circumference of a circle with this radius is %ld", 0
calculation2 db " and %ld/7 meters.", 10, 0
goodbye db "The integer part of the area will be returned to the main program. Please enjoy your circles.", 10, 0

segment .bss

;Empty segment: there are no un-initialized arrays.

segment .text
circle:

;Back up the general purpose registers for the sole purpose of protecting the data of the caller.
push rbp                                                    ;Backup rbp
mov  rbp,rsp                                                ;The base pointer now points to top of stack
push rdi                                                    ;Backup rdi
push rsi                                                    ;Backup rsi
push rdx                                                    ;Backup rdx
push rcx                                                    ;Backup rcx
push r8                                                     ;Backup r8
push r9                                                     ;Backup r9
push r10                                                    ;Backup r10
push r11                                                    ;Backup r11
push r12                                                    ;Backup r12
push r13                                                    ;Backup r13
push r14                                                    ;Backup r14
push r15                                                    ;Backup r15
push rbx                                                    ;Backup rbx
pushf                                                       ;Backup rflags

push qword -1                                               ;Now the number of pushes is even

;using registry in backwards configuration to minimize potential issues with an important registry to use.
;r13 = initial user input
;r14 = whole value of response
;r15 = fraction value of response
;rax and rdx are used to store responses in a double quad word configuration when needed

;write welcome message
mov qword rdi, stringoutputformat
mov qword rsi, welcome
mov qword rax, 0
call printf

;write user prompt
mov qword rdi, stringoutputformat
mov qword rsi, promptforinteger
mov qword rax, 0
call printf

;take in user user response
mov qword rdi, signedintegerinputformat
push qword 0
mov qword rsi, rsp
mov qword rax, 0
call scanf
pop qword r13

;display user response
mov qword rdi, userresponse
mov qword rsi, r13
mov qword rdx, r13
mov qword rax, 0
call printf

;calculate the circumference
;multiplying the response by 2*22 and dividing by 7 should give us the correct response
;multiplication
mov qword rax, 44 ;submit multiply values (pre-calculated 22*2=44)
mov qword rdx, 0
imul r13            ;multiply by user input
;division
;rax:rdx currently hold the recently multiplied value, which is already in proper format for division.
cqo
mov r12, 7              ; divide multiplied number by 7
idiv r12
mov qword r14, rax        ;r14 holds quotient
mov qword r15, rdx       ;r15 holds remainder

;show whole meters
mov qword rdi, calculation1
mov qword rsi, r14
mov qword rdx, r14
mov qword rax, 0
call printf
;show partial meters
mov qword rdi, calculation2 ;rdi
mov qword rsi, r15
mov qword rdx, r15
mov qword rax, 0
call printf

;display goodbye message
mov qword rdi, stringoutputformat
mov qword rsi, goodbye
mov qword rax, 0
call printf

;save the whole number response in rax, so it can be sent to egyptian.c
mov qword rax, r14

;Restore the original values to the general registers before returning to the caller.
pop r15                                                     ;Remove the extra -1 from the stack
popf                                                        ;Restore rflags
pop rbx                                                     ;Restore rbx
pop r15                                                     ;Restore r15
pop r14                                                     ;Restore r14
pop r13                                                     ;Restore r13
pop r12                                                     ;Restore r12
pop r11                                                     ;Restore r11
pop r10                                                     ;Restore r10
pop r9                                                      ;Restore r9
pop r8                                                      ;Restore r8
pop rcx                                                     ;Restore rcx
pop rdx                                                     ;Restore rdx
pop rsi                                                     ;Restore rsi
pop rdi                                                     ;Restore rdi
pop rbp                                                     ;Restore rbp

;pass back the whole number
ret
