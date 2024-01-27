.model small
.data
    prompt_message db 13, 10, "Enter name: ", "$"
    newline db 13, 10, "$" ;new line variable (declaration)
    inputted_string db 26, ?, 26 dup("$") ;dynamic daw, gumagamit ng memory allocation
                       ;0  1   2
    ;variable that will capture the inputted string, buffer size, blank data/actual string length, buffer size duplicate of dollar signs/actual string
    
    ;pag question mark, blank data
    ;buffer size = 26

.stack 100h
.code

    main proc near

    ; Initializing data
    mov ax, @data
    mov ds, ax

    ; Displaying message
    lea dx, prompt_message ; synonym = mov dx, offset message
    mov ah, 09h
    int 21h

    ;mapupunta sya kay inputted string
    ;13 is ung pang enter
    mov ah, 0ah
    lea dx, inputted_string
    int 21h

    ;shortcut for new line
    lea dx, newline
    mov ah, 09h
    int 21h

    mov ah, 09h
    lea dx, [inputted_string + 2]
    int 21h

    mov ax, 4c00h
    int 21h
    ;samme lang silang dalawa
    ;mov ax, 4c00h
    ;mov al, 00h ; minsan tinatanggal tong al
    ;int 21h

    main endp
end main
