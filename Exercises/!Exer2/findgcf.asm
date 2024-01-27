.model small
.stack 100h
.data
    newline db 13, 10, "$"
    message1 db 13, 10, "Enter first number: ", "$"   
    message2 db 13, 10, "Enter second number: ", "$"   
    message3 db "The greatest common factor of ", "$"
    message4 db " and ", "$"
    message5 db " is ", "$"
    inp1_huns db ?
    inp1_tens db ?
    inp1_ones dw ?
    inp2_huns db ?
    inp2_tens db ?
    inp2_ones dw ?
    total dw ?
    total2 dw ?
    rem dw ?
    ph dw ?

.code
    printzero proc near
    mov ah, 02h
    mov dl, '0'
    int 21h
    ret
    printzero endp

    find_gcf proc near
    xor bx, bx
    mov bx, total
    .if bx < total2
        mov ph, bx    
        mov bx, total2      
        mov total, bx      
        mov bx, ph     
        mov total2, bx      
    .endif

    .if total2 == 00
        mov ax, total
        call printnum
    .else
        xor ax, ax
        mov ax, total
        mov bx, 01
        mul bx

        xor bx, bx
        add bx, total2
        div bx
        mov rem, dx

        .if rem == 0
            mov ax, total2
            call printnum
        .else
            mov bx, total2
            mov total, bx
            mov bx, rem
            mov total2, bx
            call find_gcf
        .endif
    .endif

    ret
    find_gcf endp

    printnum proc near
    mov bx, 10         
    xor cx, cx          
    
    @divloop: 
    xor dx, dx         
    div bx              
    push dx             
    inc cx              
    test ax, ax         
    jne @divloop          
    @increment: 
    pop dx            
    
    mov ah, 02h         
    add dl, "0"
    int 21h            
    loop @increment

    ret
    printnum endp

    printmessage proc near
    .if total == 0
        call printzero
        call printzero
        call printzero
    .elseif total < 10
        call printzero
    .elseif total < 100
        call printzero
        call printzero
    .endif
    mov ax, total
    
    call printnum

    mov ah, 09h
    lea dx, message4
    int 21h

    .if total2 == 0
        call printzero
        call printzero
        call printzero
    .elseif total2 < 10
        call printzero
    .elseif total2 < 100
        call printzero
        call printzero
    .endif
    mov ax, total2
    call printnum

    mov ah, 09h
    lea dx, message5
    int 21h

    ret
    printmessage endp

    period proc near
    mov ah, 02h
    mov dl, '.'
    int 21h
    ret
    period endp

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
    mov inp1_huns, al

    mov ah, 01h
    int 21h
    mov inp1_tens, al

    mov ah, 01h
    int 21h
    xor ah, ah
    mov inp1_ones, ax
    mov ah, 09h

    lea dx, message2
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h
    mov inp2_huns, al

    mov ah, 01h
    int 21h
    mov inp2_tens, al

    mov ah, 01h
    int 21h
    xor ah, ah
    mov inp2_ones, ax
    mov ah, 09h

    ; sub 048 from digits
    sub inp1_tens, 048
    sub inp1_huns, 048
    sub inp1_ones, 048
    sub inp2_huns, 048
    sub inp2_tens, 048
    sub inp2_ones, 048

    xor al, al
    mov al, inp1_huns
    mov bl, 100
    mul bl
    mov total, ax 

    mov al, inp1_tens
    mov bl, 10
    mul bl
    add total, ax
    mov bx, inp1_ones
    add total, bx

    mov al, inp2_huns
    mov bl, 100
    mul bl
    mov total2, ax
    

    mov al, inp2_tens
    mov bl, 10
    mul bl
    add total2, ax
    mov bx, inp2_ones
    add total2, bx

    mov ah, 09h
    lea dx, newline
    int 21h

    mov ah, 09h
    lea dx, message3
    int 21h

    call printmessage
    call find_gcf
    call period

    ; Returning to ms-dos
    mov ax, 4c00h
    int 21h

    main endp
end main