#!/bin/bash

# this script replaces all occurences of syscall in assembly with the UKL hack 
replacement='#if IS_IN(rtld)\n\tmovq _dl_entry_SYSCALL_64(%rip), %rcx\n\tcall *%rcx\n#else\n\tcall entry_SYSCALL_64@PLT\n#endif'

find . -type f \( -name "*.S" -o -name "*.h" \) -exec sed -i -E "s|^\s+syscall.{0,3}$|$replacement|g" {} \; 


# this command was helpful for finding lingering instances of syscall. Simply replace .h with .S or .c to look for more.
# grep -rn -E --include \*.c "^.*syscall" . | grep x86_64 | grep -v "*/" 
