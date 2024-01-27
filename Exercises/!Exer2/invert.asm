.model small
.stack 100h

.data
    message db 13, 10, "Enter string: ", "$"
    transformed_message db 13, 10, "Transformed string: ", "$"

    new_line db 13, 10, '$' ; carriage return and line feed characters

    input_string db 26, ?, 26 dup("$") 

.code
    main proc

        ; Initializing data
        mov ax,@data
        mov ds,ax

        ; displaying message 
        mov ah, 09h
        lea dx, message
        int 21h

        ; read user input
        mov ah, 0ah
        lea dx, input_string
        int 21h

        ; ; print output message
        mov ah, 09h
        lea dx, transformed_message
        int 21h

        ; convert string to inverted case
        xor si, si ; use SI as a counter for the input buffer. SI is set to Zero

        loop_start:
        cmp si, 10 ; check if we've reached the end of the buffer
        je end_loop
        mov al, [input_string+si+1] ; load the next character into AL
        cmp al, 'a' ; check if it's a lowercase letter
        jb not_lowercase
        cmp al, 'z'
        ja not_lowercase
        sub al, 32 ; convert to uppercase
        jmp loop_continue
        
        not_lowercase:
        cmp al, 'A' ; check if it's an uppercase letter
        jb loop_continue
        cmp al, 'Z'
        ja loop_continue
        add al, 32 ; convert to lowercase
        
        loop_continue:
        mov [input_string+si+1], al ; store the modified character back in the buffer
        inc si ; move to the next character
        jmp loop_start
        end_loop:

        ; print the transformed string
        mov ah, 9
        lea dx, input_string+2 ; skip the length byte and null terminator
        int 21h

        ; print new line character
        mov ah, 9
        lea dx, new_line
        int 21h

        ; Returning to ms-dos
        mov ax, 4c00h
        xor al, al ; set al to zero
        int 21h

    main endp
end main
