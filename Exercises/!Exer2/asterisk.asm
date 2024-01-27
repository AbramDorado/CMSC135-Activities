.model small
.stack 100h
.data
    message1 db 13, 10, "Enter number of rows (00-20): ", "$"
    error db 13, 10, "Input must be between 1-20 only!", "$"
    newline db 13, 10, "$"
    var db ?
    inp_ones db ?
    inp_tens dw ?

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

    ; Displaying Input message
    lea dx, message1
    mov ah, 09h
    int 21h

     ; Gets user input
    mov ah, 01h
    int 21h

    ; Copy user input to input variable
    mov inp_ones, al

    ; Gets user input
    mov ah, 01h
    int 21h

    ; Copy user input to input variable
    xor ah, ah
    mov inp_tens, ax
    mov ah, 09h

    mov ah, 09h
    lea dx, newline
    int 21h

    ; sub 048 from digits
    sub inp_tens, 048
    sub inp_ones, 048

    ; multiply 10 to the tens digit
    mov al, inp_ones
    mov bl, 10
    mul bl

    ; add ones and tens digit
    add ax, inp_tens
    mov bl, 1d
    div bl

    cmp ax, 20d
    jle @continue
    jg @display_error

    @continue:
    xor cx, cx
    mov cl, al

    mov bh, 01
    mov var, 01   

    .while bh <= cl
        .while var <= bh
            mov ah, 02h
            mov dl, '*'
            int 21h
            inc var
        .endw
        mov ah, 09h
        lea dx, newline
        int 21h
        inc bh
        mov var, 01
    .endw
    jmp @end_condition

    @display_error:
    mov ah, 09h
    lea dx, error
    int 21h
    
    @end_condition:
    ; Returning to ms-dos
    mov ax, 4c00h
    int 21h

    main endp
end main