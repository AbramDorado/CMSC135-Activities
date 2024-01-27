;this tells if the character is upper or lower case

.model small
.stack 100h
.data
    enter_message db 13, 10, "Enter character: ", "$"

    uppercase_message db 13, 10, "Upper case! ", "$"
    lowercase_message db 13, 10, "Lower case! ", "$"

    newline db 13, 10, "$" 
    
    input db ?

.code
    main proc near

    ; Initializing data
    mov ax, @data
    mov ds, ax

    ; displaying message 1
    lea dx, enter_message
    mov ah, 09h
    int 21h
    ; Gets user input
    mov ah, 01h
    int 21h
    
    mov input, al

    cmp al, 90

    jle @display_uppercase
    jg @display_lowercase

    @display_uppercase: 
	mov ah, 09h
	lea dx, uppercase_message
	int 21h

    jmp @end_condition

    @display_lowercase:
    mov ah, 09h
    lea dx, lowercase_message
    int 21h

    @end_condition:
    ; Returning to ms-dos
    mov ax, 4c00h
    int 21h

    main endp
end main