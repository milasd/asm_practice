// Basic FizzBuzz implementation. 
// Print "Fizz" if number is divisible by 3, print "Buzz" if number if divisible by 5, "FizzBuzz" if 3 and 5
.global _main
.align 4

_main:
    // numbers for fizz buzz
    mov X9, #15
    bl fizz_buzz

    mov X9, #3
    bl fizz_buzz

    mov X9, #5
    bl fizz_buzz

    mov X9, #11
    bl fizz_buzz

    //end program
    b exit

fizz_buzz:
    stp X29, X30, [SP, #-16]!       // Save return address to _main

    // Check if number is divisible by 15
    mov X6, #15
    bl check_divisible
    beq print_fizzbuzz

    // Check if number is divisible by 3
    mov X6, #3
    bl check_divisible
    beq print_fizz

    // Check if number is divisible by 5
    mov X6, #5
    bl check_divisible
    beq print_buzz

    ldp X29, X30, [SP], #16     // Restore address and return to _main
    ret

check_divisible:
    udiv X5, X9, X6
    msub X7, X5, X6, X9         // Calculate remainder
    cmp X7, #0
    ret

print_fizzbuzz:
    adr X1, fizzbuzz
    mov X2, #8
    bl println
    ldp X29, X30, [SP], #16     // Restore and return to _main
    ret

print_fizz:
    adr X1, fizz
    mov X2, #4
    bl println
    ldp X29, X30, [SP], #16     // Restore and return to _main
    ret

print_buzz:
    adr X1, buzz
    mov X2, #4
    bl println
    ldp X29, X30, [SP], #16     // Restore and return to _main
    ret

println:
    mov X0, #1
    mov X16, #4
    svc 0x80

    // println \n for newline
    adr X1, newline
    mov X2, #1
    mov X0, #1
    mov X16, #4
    svc 0x80
    ret

exit:
    mov X0, #0
    mov X16, #1
    svc 0x80 


fizz: 
    .ascii "Fizz"
buzz: 
    .ascii "Buzz"
fizzbuzz: 
    .ascii "FizzBuzz"
newline:
    .ascii "\n"