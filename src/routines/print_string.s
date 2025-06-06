// Print a string 

.global _main
.align 4

_main:
    adr X1, message     // Load address of message into register X1
    mov X2, #14         // Length of message
    bl print
    mov X0, #0          // Exit code 0 to register X0
    b exit

print:
    mov X16, #4         // Syscall 'write': 4
    mov X0, #1          // write to stdout
    svc #0x80           // Execute syscall
    ret                 // Return to the address registered in X30 (link created in bl print)

exit:
    mov X16, #1         // Syscall 'exit': 1
    svc #0x80           // Execute the syscall w/ exit code 0, terminating the program

message: 
    .ascii "Hello, World!"