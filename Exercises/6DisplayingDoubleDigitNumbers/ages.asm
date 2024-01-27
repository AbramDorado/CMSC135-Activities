.model small
.data
    message_name db 13, 10, "Enter name: ", "$"
    message_age db 13, 10, "Enter age: ", "$"
    message_hello db 13, 10, "Hello ", "$"
    message_you db 13, 10, "You are ", "$"
    message_years db " years old ", "$"
    newline db 13, 10, "$" 
    input_name db 26, ?, 26 dup("$")
    input_ones db ?
    input_tens db ?

.stack 100h
.code
    main proc near
        mov ax, @data
        mov ds, ax

        ; displaying name message prompt
        lea dx, message_name
        mov ah, 09h
        int 21h

        ; getting string name
        mov ah, 0ah
        lea dx, input_name
        int 21h   

        ; new line
        lea dx, newline
        mov ah, 09h
        int 21h

        ; displaying age message prompt
        lea dx, message_age
        mov ah, 09h
        int 21h

        ; get ones
        mov ah, 01h
        int 21h
        mov input_ones, al

        ; get tens
        mov ah, 01h
        int 21h
        mov input_tens, al

        ; new line
        lea dx, newline
        mov ah, 09h
        int 21h

        ; displaying hello message prompt
        lea dx, message_hello
        mov ah, 09h
        int 21h

        ; displaying string name
        mov ah, 09h
        lea dx, [input_name + 2]
        int 21h

        ; displaying you message prompt
        lea dx, message_you
        mov ah, 09h
        int 21h

        ; displaying ones
        mov ah, 02h
        mov dl, input_ones
        int 21h

        ; displaying tens
        mov ah, 02h
        mov dl, input_tens
        int 21h

        ; displaying years message prompt
        lea dx, message_years
        mov ah, 09h
        int 21h

        ; returning to ms dos
        mov ax, 4c00h
        int 21h

        main endp
    end main