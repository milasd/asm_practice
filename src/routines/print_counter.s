// Print numbers from 9 to 0 by converting the number to a string

.global _main
.align 4

_main:
    mov X9, #9          // counter = 9
    
counter:                 
    add X10, X9, #48    // convert number to ASCII ('0' + number)
    sub sp, sp, #16     // make space on stack (16-byte aligned)
    strb W10, [sp]      // store ASCII character on stack
    
    mov X1, sp          // Load address of character into register X1
    mov X2, #1          // length of message
    bl print
    
    add sp, sp, #16     // restore stack

    subs X9, X9, #1     // subtract 1 from counter
    bge counter         // jump back to loop if counter >= 0
    
    mov X0, #0          // Exit code 0
    b exit

print:
    mov X16, #4         // 'write' syscall
    mov X0, #1          // stdout
    svc 0x80            // execute syscall
    ret                 // return to link on X30

exit:
    mov X16, #1         // Exit syscall, w/ code 0 (X0).
    svc 0x80            // execute syscall