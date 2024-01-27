.model small
.data
	prompt_message db 13, 10, "Enter expression: ", "$"
	invalid_message db 13, 10, "Invalid operator", "$"
	first_input dw ?
	second_input dw ?
	operator db ?

	newline db 13, 10, "$"
	andtxt db " and ", "$"
	istxt db " is ", "$"
	periodtxt db ".", "$"
	negtxt db "-", "$"

	result dw 0

	input1 db 2 dup(?)
	input2 db 2 dup(?)

	negnum db 0
	decimal db 10

	prompt_add db 13, 10, "The sum of ", "$"
	prompt_sub db 13, 10, "The difference of ", "$"
	prompt_mul db 13, 10, "The product of ", "$"

	prompt_div db 13, 10, "The quotient is ", "$"
	prompt_rem db " and the remainder is ", "$"

	quot db ?
	rem db ?

.stack 100h
.code
	display_txt proc near
		lea si, input1
		xor cx, cx
		mov cx, 2

		@display1:
		mov dl, [si]
		mov ah, 02h
		int 21h 

		inc si
		loop @display1

		lea dx, andtxt
		mov ah, 09h
		int 21h

		lea si, input2
		xor cx, cx
		mov cx, 2

		@display2:
		mov dl, [si]
		mov ah, 02h
		int 21h 

		inc si
		loop @display2

		lea dx, istxt
		mov ah, 09h
		int 21h

		ret
	display_txt endp

	display_res proc near
		; take result and parse it
		mov ax, result
		mov bx, 10
		mov cx, 4

		back:
	        mov dx, 0            ;clear dx
	        div bx               ;DIV AX/10
	        add dx, 48           ;ADD 48 TO REMAINDER TO GET ASCII CHARACTER OF NUMBER 
	        dec si               ; store characters in reverse order
	        mov [si], dl

	        cmp ax, 0            
	        jz extt              ;IF AX=0, END OF THE PROCEDURE
	        jmp back             ;ELSE REPEAT
		extt:
	        @displaynum:
	        	mov dl, [si]
				.if dl >= 48 && dl <= 57
					mov ah, 02h
					int 21h 
				.endif

				inc si
				loop @displaynum

	    ret
	display_res endp

	main proc near

		mov ax, @data
		mov ds, ax

		lea si, input1

		lea dx, prompt_message
		mov ah, 09h
		int 21h

		mov ah, 01h
		int 21h
		mov [si], al
		inc si

		sub al, 48
		mov bl, 10
		mul bl
		add first_input, ax
		
		mov ah, 01h
		int 21h
		mov [si], al
		inc si

		sub al, 48
		mov bl, 01
		mul bl
		add first_input, ax

		mov ah, 01h
		int 21h
		mov operator, al

		lea si, input2

		mov ah, 01h
		int 21h
		mov [si], al
		inc si

		sub al, 48
		mov bl, 10
		mul bl
		add second_input, ax
		
		mov ah, 01h
		int 21h
		mov [si], al
		inc si

		sub al, 48
		mov bl, 01
		mul bl
		add second_input, ax

		.if operator == 42 ; multiply
			mov ax, first_input
			mov bx, second_input
			mul bx

			mov result, ax

			; output in ax
			lea dx, prompt_mul
			mov ah, 09h
			int 21h

			call display_txt
			call display_res

			lea dx, periodtxt
			mov ah, 09h
			int 21h

		.elseif operator == 43 ; addition
			mov ax, first_input
			add result, ax

			mov ax, second_input
			add result, ax

			lea dx, prompt_add
			mov ah, 09h
			int 21h

			call display_txt
			call display_res

			lea dx, periodtxt
			mov ah, 09h
			int 21h

		.elseif operator == 45 ; subtraction
			mov ax, first_input
			.if second_input > ax
				mov bx, second_input
				mov first_input, bx
				mov second_input, ax

				mov ax, first_input
				add negnum, 1
			.endif

			add result, ax
			mov ax, second_input
			sub result, ax

			lea dx, prompt_sub
			mov ah, 09h
			int 21h

			call display_txt

			.if negnum > 0 
				lea dx, negtxt
				mov ah, 09h
				int 21h
			.endif

			call display_res

			lea dx, periodtxt
			mov ah, 09h
			int 21h
		.elseif operator == 47 ; division
			mov ax, second_input
			mov bl, 1
			div bl

			mov bl, al
			mov ax, first_input
			div bl

			mov rem, ah

			mov bl, 1
			mul bl

			mov result, ax

			; quotient ax or al
			; remainder dx or ah
			
			lea dx, prompt_div
			mov ah, 09h
			int 21h

			call display_res

			lea dx, prompt_rem
			mov ah, 09h
			int 21h

			mov al, rem
			mul bl
			mov result, ax
			call display_res

			lea dx, periodtxt
			mov ah, 09h
			int 21h
		.else

			lea dx, invalid_message
			mov ah, 09h
			int 21h

			mov ax, 4c00h
			int 21h

		.endif

		mov ax, 4c00h
		int 21h

	main endp
end main
	