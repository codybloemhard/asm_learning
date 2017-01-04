extrn PrintInt		:	proc				;PrintInt func
extrn PrintString	:	proc				;PrintString func
extrn Notify		:	proc				;Print notification
extrn PrintArr		:	proc				;Print int array

.data

string db 'hello', 0
yes db 'YES', 0
no db 'NO', 0

.code

_print_int macro value
	push rcx
	mov ecx, value							;first and only parameter
	call PrintInt							;call function
	pop rcx
endm

_print_str macro str
	sub rsp, 20h							;reserve shadowspace on stack
	mov rcx, offset str						;the pointer pointing to the string as parameter
	call PrintString						;call
	add rsp, 20h							;restore stack
endm

_begin_call macro
	push rax
	push rbx
	push rcx
	push rdx
	push r8
	push r9
	push rsi
	push rdi
endm

_end_call macro
	pop rdi
	pop rsi
	pop r9
	pop r8
	pop rdx
	pop rcx
	pop rbx
	pop rax
endm

_print_arr macro
	_begin_call
	mov ecx, 10
	call PrintArr
	_end_call
endm

GetAsmX64 proc
	;int len, int* arr - bubble sort dat shit
	;rdx = arr
	xor rax, rax							;j = 0
	xor ebx, ebx							;temp
	mov esi, ecx							;len in esi
	xor ecx, ecx							;i = 0;
	xor rdi, rdi							;util
	xor r8, r8								;util
	xor r9, r9								;util
	
	mov ecx, 1								;i = 1
	MAINLOOP:
		
		xor eax, eax						;j = 0
		mov edi, esi						;j = len
		sub edi, ecx						;j = len - i
		INNERLOOP:
			mov r8d, [rdx + rax*4]				;temp0 = a[j]
			cmp r8d, [rdx + rax*4 + 4]			;if(a[j] > a[j + 1])
			jng EXITIF							;''					
				mov r9, [rdx + rax*4 + 4]		;temp1 = a[j + 1]
				mov [rdx + rax*4 + 4], r8d		;a[j + 1] = temp0
				mov [rdx + rax*4], r9d			;a[j] = temp1
		EXITIF:
		inc eax									;for(j = 0; j < len - i; j++)
		cmp eax, edi							;''
		jnz	INNERLOOP						

	inc ecx
	cmp ecx, esi
	jl MAINLOOP

	xor rax, rax
	ret
GetAsmX64 endp
end
