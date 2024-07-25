#ifndef __TIEMPO_H__
#define __TIEMPO_H__

// uso: 
// unsigned long start, end;
// MEDIR_TIEMPO_START(start);
// ... codigo ...
// MEDIR_TIEMPO_STOP(end);
// unsigned long delta = end - start;

#define MEDIR_TIEMPO(var)                                   \
{                                                           \
    __asm__ __volatile__ (                                  \
        "xor %%rdx, %%rdx\n\t"                              \
        "xor %%rax, %%rax\n\t"                              \
        "lfence\n\t"                                        \
        "rdtsc\n\t"                                         \
        "sal $32, %%rdx\n\t"                                \
        "or %%rdx, %%rax\n\t"                               \
        "movq %%rax, %0\n\t"                                \
        : "=r" (var)                                        \
        : /* no input */                                    \
        : "%rax", "%rdx"                                    \
    );                                                      \
}


#define MEDIR_TIEMPO_START(start)                           \
{                                                           \
    /* warm up ... */                                       \
    MEDIR_TIEMPO(start);                                    \
    MEDIR_TIEMPO(start);                                    \
    MEDIR_TIEMPO(start);                                    \
}

#define MEDIR_TIEMPO_STOP(end)                              \
{                                                           \
    MEDIR_TIEMPO(end);                                      \
}

#endif /* !__TIEMPO_H__ */
