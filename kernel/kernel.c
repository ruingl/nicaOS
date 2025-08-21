/**
 * nicaOS v0.0.2-indev
 * made with <3 by rui
 *
 * named from the loml
 * proudly written with termux
 * proudly written in nano
 */

#include <stddef.h>
#include <stdint.h>

#define VGA_WIDTH 80
#define VGA_HEIGHT 25
#define VGA_MEMORY 0xB8000

static uint16_t* const VGA_BUFFER = (uint16_t*) VGA_MEMORY;
static size_t cursor_row = 0;
static size_t cursor_col = 0;
static uint8_t color = 0x0F;

static inline uint16_t vga_entry(char c, uint8_t color) {
  return (uint16_t)c | (uint16_t)color << 8;
}

void putchar(char c) {
  if (c == '\n') {
    cursor_row++;
    cursor_col = 0;
  } else {
    VGA_BUFFER[cursor_row * VGA_WIDTH + cursor_col] = vga_entry(c, color);
    cursor_col++;
    if (cursor_col >= VGA_WIDTH) {
      cursor_col = 0;
      cursor_row++;
    }
  }

  if (cursor_row >= VGA_HEIGHT) {
    cursor_row = 0;
  }
}

void print(const char* str) {
  for (size_t i = 0; str[i] != '\0'; i++) {
    putchar(str[i]);
  }
}

void kernel_main(void) {
  print("Welcome to nicaOS (v0.0.1-indev) (x86)\n");
  print("Have fun! This is kernel level.\n");
  for (;;) {}
}
