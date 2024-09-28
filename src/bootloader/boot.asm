org 0x7C00	; Set code origin to 0x7C00, where BIOS loads the bootloader
bits 16	; Set processor to 16-bit mode (real mode)


%define ENDL 0x0D, 0x0A	; Define ENDL as the carriage return (CR, 0x0D) and line feed (LF, 0x0A) sequence


start:
	jmp main	; Jump to the main function to begin execution
	

;
; Prints a string to the screen
; Parameters:
;	- ds:si points to string
;
puts:
	; Save registers we will modify
	push si
	push ax
	
.loop:
	lodsb	; Loads a byte from ds:si into in al and increments si by the number of bytes loaded
	or al, al	; Performs bitwise OR to verify if next char is null
	jz .done
	
	mov ah, 0x0E  ; Set AH to 0x0E for teletype output function (print character)
	int 0x10      ; Call BIOS interrupt 0x10 to display the character in AL
	
	jmp .loop
	
.done:
	; Restore register values
	pop ax
	pop si
	ret	; Return from current procedure to the caller


; Entry point of the program
main:
	; Setup data segments
	mov ax, 0	; We cannot write to ds/es directly so we use an intermediary register
	mov ds, ax
	mov es, ax
	
	; Setup stack
	mov ss, ax
	mov sp, 0x7C00	; Set the stack pointer to the start of the stack at memory address 0x7C00
	
	; print message
	mov si, msg_hello
	call puts

	hlt	; Halt CPU execution
	
.halt:
	jmp .halt	; Infinite loop to prevent further execution

	
msg_hello: db 'Hello World!', ENDL, 0
	
; Ensures the boot sector is exactly 512 bytes long
times 510-($-$$) db 0	; Fill the rest of the boot sector with zeros (up to 510 bytes)
dw 0AA55h	; Boot signature (0xAA55), required for valid boot sector
