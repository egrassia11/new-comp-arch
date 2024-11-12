int main();

/*
 * _start()
 *
 * startup code to initialize things and call main(). Should be located at
 * address 0 in instruction mem. Put it at the beginning of the C file to make
 * the compiler place it at addr 0.
 *
 */
__attribute__((naked)) void _start() {
    asm("li sp,4096");  // set up the stack pointer
    main();             // call main()
    while (1);          // Spin loop when main() returns
}

int simple_function(int x, int y) {
    return x + y;       // Generate `add` for function call
}

int main() {
    int a = 5, b = 10, result;

    // Test arithmetic instructions: add, sub
    result = a + b;
    result = b - a;

    // Test logical operations: and, or, xor
    result = a & b;
    result = a | b;
    result = a ^ b;

    // Test immediate operations: addi, andi, ori
    result = a + 1;
    result = a & 0xF;
    result = a | 0xF;

    // Test shift instructions: sll, srl, sra
    result = b << 1;
    result = b >> 1;
    result = b >> 1;

    // Test load and store instructions: lw, sw
    int array[2];
    array[0] = result;
    int load_result = array[0];

    // Test control flow: beq, bne, blt, bge, jal
    for (int i = 0; i < 5; i++) {
        if (i == 3) {
            result += 2;
        }
        if (i != 3) {
            result += 1;
        }
        if (i < 3) {
            result += 3;
        }
        if (i >= 3) {
            result += 4;
        }
    }

    // Test jump and link: jal (function call)
    result = simple_function(a, b);

    /*
       for (int k = 0; k < 100; k++) {
       asm("add x0,x0,x0");
       }
     */

    return 0;
}

