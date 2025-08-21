; nicaOS v0.0.1-indev
; made with <3 by rui
;
; named from the loml
; proudly written with termux
; proudly written in nano

section .multiboot
align 8
  dd 0x1BADB002         ; magic number
  dd 0x00               ; flags
  dd -(0x1BADB002+0x00) ; checksum

section .text
global _start

extern kernel_main

_start:
  cli                ; clear interrupts
  mov esp, stack_top ; set stack pointer
  call kernel_main   ; start kernel

hang:
  hlt
  jmp hang

section .bss
resb 8192
stack_top:
