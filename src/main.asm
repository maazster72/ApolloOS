org 0x7C00	; Set code origin to 0x7C00, where BIOS loads the bootloader
bits 16	; Set processor to 16-bit mode (real mode)


; Entry point of the program
main:
	; Setup data segments
	mov ax, 0	; We cannot write to ds/es directly so we use intermediary register
	mov ds, ax
	mov es, ax
	
	; Setup stack
	mov ss, ax
	mov sp, 0x7C00	; Set the stack pointer to the start of the stack at memory address 0x7C00

	hlt	; Halt CPU execution
	
.halt:
	jmp .halt	; Infinite loop to prevent further execution
	
; Ensures the boot sector is exactly 512 bytes long
times 510-($-$$) db 0	; Fill the rest of the boot sector with zeros (up to 510 bytes)
dw 0AA55h	; Boot signature (0xAA55), required for valid boot sector
