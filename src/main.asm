org 0x7C00	; Set code origin to 0x7C00, where BIOS loads the bootloader
bits 16	; Set processor to 16-bit mode (real mode)


; Entry point of the program
main:
	hlt	; Halt CPU execution
	
.halt:
	jmp .halt	; Infinite loop to prevent further execution
	
; Ensures the boot sector is exactly 512 bytes long
times 510-($-$$) db 0	; Fill the rest of the boot sector with zeros (up to 510 bytes)
dw 0AA55h	; Boot signature (0xAA55), required for valid boot sector
