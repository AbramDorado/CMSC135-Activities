.model small    ; default
.stack 100h     ; default 256
.data
    message db 13, 10, "Hello world", "$"
    ; variable name, size, carriage return, line feed, text, null terminator
.code
    main proc near ; proc = procedure

; Initializing data
    mov ax, @data  ; move data to ax register
    mov ds, ax     ; move ax to ds

; Displaying message
    mov dx, offset message
    mov ah, 09h    ; print string 
    int 21h        ; interrupt call, msdos services, trigger that something will be done

; Returning to ms-dos,   end of program
    mov ax, 4c00h
    int 21h

    main endp      ; end procedure
end main
