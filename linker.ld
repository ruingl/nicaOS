/**
 * nicaOS v0.0.2-indev
 * made with <3 by rui
 *
 * named from the loml
 * proudly written with termux
 * proudly written in nano
 */

ENTRY(_start)

SECTIONS {
  . = 1M;
  .text : { *(.multiboot) *(.text) }
  .data : { *(.data) }
  .bss  : { *(.bss)  }
}
