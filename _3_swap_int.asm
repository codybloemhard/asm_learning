extrn PrintInt:proc							;PrintInt func
extrn PrintString:proc						;PrintString func

.data

string db 'hello string from asm here', 0

.code

_print_int macro value
	sub rsp, 20h							;reserve shadowspace on the stack
	mov ecx, value							;first and only parameter
	call PrintInt							;call function
	add rsp, 20h							;restore stack
endm

_print_string macro str
	sub rsp, 20h							;reserve shadowspace on stack
	mov rcx, offset str						;the pointer pointing to the string as parameter
	call PrintString						;call
	add rsp, 20h							;restore stack
endm

GetAsmX64 proc
	;int* a, int* b, swap values
	mov rax, [rcx]
	mov rbx, [rdx]
	mov [rcx], rbx
	mov [rdx], rax

	xor eax, eax							;return 0 to c++
	ret
GetAsmX64 endp
end
