extern print_uint64

section	.data

section	.text
	global _start
_start:                

    mov rdi, 4
    call print_uint64

    mov	eax, 1	    
	int	0x80 