extrn PrintInt:proc							;PrintInt func
extrn PrintString:proc						;PrintString func

.data

string db 'hello string from asm here', 0
replacement db 'ABCDE', 0

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
	_print_int 111
	_print_string string
	
	mov rax, offset string
	mov rsi, offset replacement
	mov	bl, [rsi + 0]
	mov byte ptr [rax + 0], bl
	mov	bl, [rsi + 1]
	mov byte ptr [rax + 1], bl
	mov	bl, [rsi + 2]
	mov byte ptr [rax + 2], bl
	mov	bl, [rsi + 3]
	mov byte ptr [rax + 3], bl
	mov	bl, [rsi + 4]
	mov byte ptr [rax + 4], bl
	
	_print_string string

	mov eax, 0								;return 0 to c++
	ret
GetAsmX64 endp
end
