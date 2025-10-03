#
# Makefile for a simple RISC-V 32-bit kernel
#

# Compiler and output files
CC = clang
TARGET = kernel.elf
MAPFILE = kernel.map
LD_SCRIPT = kernel.ld

# Source files
SRCS = kernel.c
OBJS = $(SRCS:.c=.o)

# Compiler flags
CFLAGS = -std=c11 -O2 -g3 -Wall -Wextra \
         --target=riscv32-unknown-elf -march=rv32imac -mabi=ilp32 \
         -fno-stack-protector -ffreestanding -nostdlib

# Linker flags
LDFLAGS = -fuse-ld=lld --target=riscv32-unknown-elf -march=rv32imac -mabi=ilp32 \
          -nostdlib -Wl,-T$(LD_SCRIPT) -Wl,-Map=$(MAPFILE)

# Phony targets (targets that are not files)
.PHONY: all clean

# Default target
all: $(TARGET)

# Link the kernel
$(TARGET): $(OBJS)
	@echo "Linking -> $(TARGET)"
	@$(CC) $(OBJS) $(LDFLAGS) -o $@
	@echo "  map: $(MAPFILE)"

# Compile C files
%.o: %.c
	@echo "Compiling $<"
	@$(CC) $(CFLAGS) -c $< -o $@

# Clean up build artifacts
clean:
	@echo "Cleaning build artifacts..."
	@rm -f $(OBJS) $(TARGET) $(MAPFILE)
	@echo "Done."
