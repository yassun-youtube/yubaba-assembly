nasm -f macho64 test.s
ld test.o -static -o test
./test
