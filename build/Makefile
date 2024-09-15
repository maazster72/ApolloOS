ASM=nasm	# Set the assembler to NASM

SRC_DIR=src	# Directory for source files
BUILD_DIR=build	# Directory for output files

# Create a floppy disk image from the binary file
$(BUILD_DIR)/main_floppy.img: $(BUILD_DIR)/main.bin
	cp $(BUILD_DIR)/main.bin $(BUILD_DIR).main_floppy.img	# Copy binary to floppy image
	truncate -s 1440k $(BUILD_DIR)/main_floppy.img	# Resize image to 1.44 MB

# Assemble the assembly source file into a binary
$(BUILD_DIR)/main.bin: $(SRC_DIR)/main.asm
	$(ASM) $(SRC_DIR)/main.asm -f bin -o $(BUILD_DIR)/main.bin
