CC=i686-elf-gcc
AS=nasm

CFLAGS=-std=gnu99 -ffreestanding -O2 -Wall -Wextra
LDFLAGS=-T linker.ld -nostdlib -lgcc

all: myos.bin
myos.bin: boot.o kernel.o
	$(CC) $(LDFLAGS) $^ -o $@

boot.o: boot.asm
	nasm -f elf32 $< -o $@

kernel.o: kernel.c
	$(CC) $(CFLAGS) -c $< -o $@

run:
	qemu-system-i386 -kernel myos.bin

clean:
	rm -f myos.bin boot.o kernel.o

.PHONY: all run clean
