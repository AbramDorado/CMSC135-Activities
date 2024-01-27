.model small 
.data
str1 db "Enter first number: $"
str2 db 13,10,"Enter second number: $"
str3 db 13,10,"The sum is: $"

.code

    main proc
        
        ; Initializing data
        mov ax,@data
        mov ds,ax

        ; Displaying message of str1
        lea dx,str1
        mov ah, 09h
        int 21h

        ;mapupunta sya kay inputted string
        mov ah, 01h  ; receives the answer of input
        int 21h
        
        mov bl,al   ; copy data of al to bl

        ; Displaying message of str2
        lea dx,str2
        mov ah, 09h
        int 21h
        
        ; receives the answer of input
        mov ah, 01h
        int 21h
        
        mov bh,al ; copy data of al to bh

        ; subtract 48 to configure ascii value to decimal
        sub bh,48 
        sub bl,48

        ; Displaying message of str3
        lea dx,str3
        mov ah, 09h
        int 21h   
        
        ;add the two values
        add bh,bl
        add bh,48 ; convert to ascii
        mov al,bh ; move to register al

        ;display the sum
        mov ah, 02h
        int 21h
        
        mov ax,4c00h
        int 21h
    main endp
end