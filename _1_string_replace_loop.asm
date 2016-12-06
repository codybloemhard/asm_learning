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
	
	mov rax, offset string					;move adress of string in RAX, using MOV
	lea rsi, replacement					;mov adress of replacement in RSI, using LEA
	xor rcx, rcx							;set rcx zero
	MainLoop:					
	mov	bl, [rsi + rcx]						;mov byte at index rcx in BL 
	mov [rax + rcx], byte ptr bl			;change byte in string at index rcx to bl
	inc rcx									
	cmp rcx, 5								
	jl MainLoop								;do loop again if rcx < 5
	
	_print_string string

	mov eax, 0								;return 0 to c++
	ret
GetAsmX64 endp
end
