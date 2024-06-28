#!/bin/bash

# this script replaces all occurences of syscall in assembly with the UKL hack 
replacement='#if IS_IN(rtld)\n\tmovq _dl_entry_SYSCALL_64(%rip), %rcx\n\tcall *%rcx\n#else\n\tcall entry_SYSCALL_64@PLT\n#endif'

find . -type f -name "*.S" -exec sed -i -E "s|^\s+syscall|$replacement|g" {} \; 
