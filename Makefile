# nicaOS v0.0.1-indev
# made with <3 by rui
#
# named from the loml
# proudly written with termux
# proudly written in nano

# toolchain
ASM     = nasm
CC      = gcc
LD      = ld
GRUBMK  = grub-mkrescue

# flags
ASMFLAGS = -f elf32
CFLAGS   = -m32 -ffreestanding -O2 -Wall -Wextra -nostdlib -nostartfiles
LDFLAGS  = -m elf_i386 -T linker.ld

# files
KERNEL_ASM = kernel/kernel.asm
KERNEL_C   = kernel/kernel.c
KERNEL_BIN = kernel.bin
ISO        = nicaOS.iso

# build steps
all: $(ISO)

$(ISO): $(KERNEL_BIN)
	cp $(KERNEL_BIN) iso/boot
	$(GRUBMK) -o $(ISO) iso

$(KERNEL_BIN): kernel.o kernel_c.o
	$(LD) $(LDFLAGS) -o $@ $^

kernel.o: $(KERNEL_ASM)
	$(ASM) $(ASMFLAGS) $< -o $@

kernel_c.o: $(KERNEL_C)
	$(CC) $(CFLAGS) -c $< -o $@

# clean
clean:
	rm -f *.o $(KERNEL_BIN) $(ISO)
	rm -rf iso/boot/kernel.bin
