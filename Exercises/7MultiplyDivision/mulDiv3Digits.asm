title Multiplication
; @author Lorenz Timothy Barco Ranera

.model small
.stack 100h
.data
    product dw ?
    product_units db ?
    product_tens db ?
    product_hundreds db ?
    decimal db 10

.code
    main proc near

    ; cleaing data
    mov ax, @data
    mov ds, ax

    ; al + bl= product
    ; product is stored in ax
    mov al, 12
    mov bl, 12
    mul bl

    ; product = ax
    mov product, ax

    ; get units digit of the product
    ; ax / bl = quotient and remainder
    ; al = quotient
    ; ah = remainder
    div decimal
    mov product_units, ah

    ; get hundreds and tens digit of the product
    ; ax / bl = quotient and remainder
    ; al = quotient
    ; ah = remainder

    mov ah, 00
    div decimal

    mov product_tens, ah
    mov product_hundreds, al

    ; display product
    mov dl, product_hundreds
    add dl, '0' ;print the number itself
    mov ah, 02h
    int 21h

    mov dl, product_tens
    add dl, "0"
    mov ah, 02h
    int 21h

    mov dl, product_units
    add dl, "0"
    mov ah, 02h
    int 21h

    ; Returning to ms-dos
    mov ax, 4c00h
    int 21h

    main endp
end main