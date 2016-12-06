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
	;(int* a,int* b,int len)
	cmp r8d, 0								;check for 0 len
	jle Finished							;skip program

	mov r10, rcx							;move a[] 
	mov r11, rdx							;move b[]
	mov r12d, r8d							;move len
	xor rcx, rcx							;clear count
	xor rax, rax							;clear a count
	xor rbx, rbx							;clear b count
	xor rdx, rdx							;clear z count
	
	MainLoop:
	mov r13d, [r10 + rcx * 4]
	cmp r13d, [r11 + rcx * 4]
	jl AddB
	je AddZ
	inc eax
	jmp Continue
	AddB:
	inc ebx
	jmp Continue
	AddZ:
	inc edx
	Continue:
	inc ecx								
	cmp ecx, r12d							;loop end??
	jl MainLoop

	Finished:
	;_print_int eax
	;_print_int ebx
	;_print_int edx

	xor eax, eax							;return 0 to c++
	ret
GetAsmX64 endp
end
