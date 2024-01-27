;this prints the number of x base on the digit
;with the space

.model small
.stack 100h
.data
    enter_message db 13, 10, "Enter number: ", "$"
    newline db 13, 10, "$" 
    input db ?

.code

    print_space proc near
        mov dl, 32
        mov ah, 02h
        int 21h
        ret
    print_space endp

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

    ; new line
    lea dx, newline
    mov ah, 09h
    int 21h

    ; mov ah, 01h 
    ; int 21h
    

    sub al, 048
    ;al <- user input(0-9)

    xor cx, cx      ;cx|00|09|
    mov cl, al       ; setting up the numebr of iternations

    ;*number of iteration is cx

    @display_x: 
    mov ah, 02h
    mov dl, 'X'
    int 21h
    call print_space ;;;;;;;

    loop @display_x

    mov ax, 4c00h
    int 21h

    main endp
end main

