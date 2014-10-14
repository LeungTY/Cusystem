#!/bin/bash

echo '---------Cusystem--------- '
echo 'By 夢遺蘿莉@香港高登'

echo '開始處理ASM檔...'

nasm ./boot/bootloader1.asm -f bin -o loader1.bin

nasm ./boot/bootloader2.asm -f bin -o loader2.bin

cat loader1.bin loader2.bin > boot.bin



dd if=/dev/zero of=floppy.img bs=512 count=1 &> /dev/null && sync

dd if=boot.bin of=floppy.img conv=notrunc &> /dev/null && sync

qemu-system-i386 floppy.img

