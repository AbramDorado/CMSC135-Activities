title Swapping
;swapping.asm
;Abram Dorado & Marvic Gabriel Ruiz

.model small
.stack 100h
.data
    first_char db 13, 10, "Enter first character (x): ", "$"
    second_char db 13, 10, "Enter second character (y): ", "$"

    message_x db 13, 10, "The new value of x is ", "$"
    message_y db 13, 10, "The new value of y is ", "$"

    newline db 13, 10, "$" 
    
    input_first db ?
    input_second db ?

.code
    main proc near

    ; Initializing data
    mov ax, @data
    mov ds, ax

    ; displaying message 1
    lea dx, first_char
    mov ah, 09h
    int 21h
    ; Gets user input
    mov ah, 01h
    int 21h
    ; Copy user input to input variable
    mov input_first, al

    ; new line
    lea dx, newline
    mov ah, 09h
    int 21h

    ; displaying message 2
    lea dx, second_char
    mov ah, 09h
    int 21h
    ; Gets user input
    mov ah, 01h
    int 21h
    ; Copy user input to input variable
    mov input_second, al

    ; ///////////////////////////////////////
    
    ;swap the values
    ;place the variables to a new register
    mov bl, input_first 
    mov cl, input_second
    xchg bl,cl ;exchange the value in register

    ; new line
    lea dx, newline
    mov ah, 09h
    int 21h

    ; displaying message x
    lea dx, message_x
    mov ah, 09h
    int 21h
    ; Display output x
    mov ah, 02h
    mov dl, bl
    int 21h

    ; displaying message y
    lea dx, message_y
    mov ah, 09h
    int 21h
    ; Display output y
    mov ah, 02h
    mov dl, cl
    int 21h

    ; Returning to ms-dos
    mov ax, 4c00h
    int 21h

    main endp
end main