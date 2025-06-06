// FizzBuzz implementation - macOS ARM64 (working version)
.global _main
.align 4

_main:
    // number for fizz buzz
    mov x9, #15
    bl fizz_buzz
    
    // exit
    mov x0, #0
    b exit

fizz_buzz:
    // Check if number is divisible by 15 first (both 3 and 5)
    mov x6, #15
    bl check_divisible
    beq print_fizzbuzz
    
    // Check if number is divisible by 3
    mov x6, #3
    bl check_divisible
    beq print_fizz
    
    // Check if number is divisible by 5
    mov x6, #5
    bl check_divisible
    beq print_buzz
    
    ret

check_divisible:
    udiv x5, x9, x6         // x5 = x9 / x6
    msub x7, x5, x6, x9     // x7 = x9 - (x5 * x6) = remainder
    cmp x7, #0              // Set Z flag if remainder is 0
    ret

print_fizzbuzz:
    adr x1, fizzbuzz        // Load address of fizzbuzz message
    mov x2, #8              // Length of "FizzBuzz"
    bl print
    ret

print_fizz:
    adr x1, fizz            // Load address of fizz message
    mov x2, #4              // Length of "Fizz"
    bl print
    ret

print_buzz:
    adr x1, buzz            // Load address of buzz message
    mov x2, #4              // Length of "Buzz"
    bl print
    ret

print:
    mov x16, #4             // Syscall 'write': 4
    mov x0, #1              // write to stdout
    svc #0x80               // Execute syscall
    ret                     // Return to caller

exit:
    mov x16, #1             // Syscall 'exit': 1
    svc #0x80               // Execute the syscall

// Data section at the end (like your working example)
fizz:
    .ascii "Fizz"
buzz:
    .ascii "Buzz"
fizzbuzz:
    .ascii "FizzBuzz"