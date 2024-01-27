.model small
.stack 100h
.data
    product dw ?
    product_units db ?
    product_tens db ?
    decimal db 10

.code
    main proc near

    ; clearing data
    mov ax, @data
    mov ds, ax

    ; al + bl= product
    ; product is stored in ax
    mov al, 09
    mov bl, 09
    mul bl

    ; product = ax
    mov product, ax

    ; get tens and units digit of the product
    ; ax / bl = quotient and remainder
    ; al = quotient
    ; ah = remainder
    div decimal

    mov product_tens, al
    mov product_units, ah

    ; display product
    ; conveerting to ascii value
    ; its just like adding 48, when we use '0'
    mov dl, product_tens
    add dl, '0' ;print the number itself, 0 = 48
    mov ah, 02h
    int 21h

    mov dl, product_units
    add dl, "0" ;print the number itself, 0 = 48
    mov ah, 02h
    int 21h

    ; Returning to ms-dos
    mov ax, 4c00h
    int 21h

    main endp
end main