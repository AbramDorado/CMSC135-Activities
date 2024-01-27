; Create a difference-finder program that accepts two two-digit integers (00-99). 
; The program shall display the correct sum and difference.
; Also assume that I will always input the larger number as first number.

; Marvic Gabriel Ruiz
; Abram Conorado Dorado

.model small
.stack 100h
.data
    message1 db 13, 10, "Enter first number (00-99): ", "$"
    message2 db 13, 10, "Enter second number (00-99): ", "$"
    message3 db 13, 10, "The sum of ", "$"
    messageand db " and ", "$"
    messageis db " is ", "$"
    message4 db "The difference of ", "$"
    newline db 13, 10, "$"
    int1_ones db ?
    int1_tens db ?
    int2_ones db ?
    int2_tens db ?
    result_sum1 db ?
    result_sum2 db ?
    result_sum3 db ?
    result_diff1 db ?
    result_diff2 db ?

.code
    main proc near

; Initializing data
    mov ax, @data
    mov ds, ax

; Displaying message
    lea dx, message1
    mov ah, 09h
    int 21h

; Gets user input
    mov ah, 01h
    int 21h

; Copy user input to input variable
    mov int1_ones, al

; Gets user input
    mov ah, 01h
    int 21h

; Copy user input to input variable
    mov int1_tens, al
    mov ah, 09h


; Displaying message
    lea dx, message2
    mov ah, 09h
    int 21h

; Gets user input
    mov ah, 01h
    int 21h

; Copy user input to input variable
    mov int2_ones, al

; Gets user input
    mov ah, 01h
    int 21h

; Copy user input to input variable
    mov int2_tens, al
    mov ah, 09h

; Performs addition

; Subtract 48 to convert it from ASCII to a numeric value
    sub int1_tens, 048
    sub int1_ones, 048
    sub int2_tens, 048
    sub int2_ones, 048

    mov bh, 00
    add bh, int1_tens
    add bh, int2_tens
    mov result_sum1, bh
    .if result_sum1 <= 9
        mov bh, result_sum1
        mov result_sum1, bh

        mov bh, 00
        add bh, int1_ones
        add bh, int2_ones
        mov result_sum2, bh
        .if result_sum2 > 9
            mov bh, result_sum2
            sub bh, 010
            mov result_sum2, bh
            add result_sum3, 01
        .endif
    .elseif result_sum1 > 9
        mov bh, result_sum1
        sub bh, 010
        mov result_sum1, bh

        mov bh, 00
        add bh, int1_ones
        add bh, int2_ones
        add bh, 01
        mov result_sum2, bh
        .if result_sum2 > 9
            mov bh, result_sum2
            sub bh, 010
            mov result_sum2, bh
            add result_sum3, 01
        .endif

    .endif



; Preforms subtraction
    mov bh, 00
    add bh, int1_tens
    .if bh < int2_tens
        add bh, 010
        sub bh, int2_tens
        mov result_diff1, bh

        mov bh, 00
        add bh, int1_ones
        sub bh, int2_ones
        sub bh, 01
        mov result_diff2, bh

    .elseif bh >= int2_tens
        sub bh, int2_tens
        mov result_diff1, bh

        mov bh, 00
        add bh, int1_ones
        sub bh, int2_ones
        mov result_diff2, bh
    .endif

; Add 48 so the numeric value can be properly displayed
    add int1_ones, 048
    add int1_tens, 048
    add int2_ones, 048
    add int2_tens, 048

; Printing sum result value
    lea dx, newline
    mov ah, 09h
    int 21h

    lea dx, message3
    mov ah, 09h
    int 21h

    mov ah, 02h
    mov dl, int1_ones
    int 21h

    mov ah, 02h
    mov dl, int1_tens
    int 21h

    lea dx, messageand
    mov ah, 09h
    int 21h

    mov ah, 02h
    mov dl, int2_ones
    int 21h

    mov ah, 02h
    mov dl, int2_tens
    int 21h

    lea dx, messageis
    mov ah, 09h
    int 21h

    .if result_sum3 != 0
        mov ah, 02h
        add result_sum3, 048
        mov dl, result_sum3
        int 21h
    .endif

    .if result_sum2 != 0
        mov ah, 02h
        add result_sum2, 048
        mov dl, result_sum2
        int 21h
    .endif

    mov ah, 02h
    add result_sum1, 048
    mov dl, result_sum1
    int 21h

    mov ah, 02h
    mov dl, '.'
    int 21h

; Printing difference result value

    lea dx, newline
    mov ah, 09h
    int 21h

    lea dx, message4
    mov ah, 09h
    int 21h

    mov ah, 02h
    mov dl, int1_ones
    int 21h

    mov ah, 02h
    mov dl, int1_tens
    int 21h

    lea dx, messageand
    mov ah, 09h
    int 21h

    mov ah, 02h
    mov dl, int2_ones
    int 21h

    mov ah, 02h
    mov dl, int2_tens
    int 21h

    lea dx, messageis
    mov ah, 09h
    int 21h


    .if result_diff2 != 0
        mov ah, 02h
        add result_diff2, 048
        mov dl, result_diff2
        int 21h
    .endif

    mov ah, 02h
    add result_diff1, 048
    mov dl, result_diff1
    int 21h

    mov ah, 02h
    mov dl, '.'
    int 21h

; Returning to ms-dos
    mov ax, 4c00h
    int 21h

    main endp
end main