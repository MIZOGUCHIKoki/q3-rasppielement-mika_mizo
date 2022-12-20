AS = arm-none-eabi-as 
LD = arm-none-eabi-ld
OBJ = arm-none-eabi-objcopy
LDFRAGS = -m armelf
OBJFLAGS = -O binary



%.img: %.elf
	$(OBJ) $< $(OBJFLAGS) $@

<<<<<<< HEAD
swframe.elf: frame.o frame_buffer.o swframe.o
	$(LD) $(LDFRAGS) $+ -o $@
count.elf: count.o frame.o
=======
count.elf: count.o display.o
>>>>>>> 70b02499f99f2c6bdd054a203437186f507c7f8a
	$(LD) $(LDFRAGS) $+ -o $@

%.elf: %.o
	$(LD) $(LDFRAGS) $< -o $@

%.o: %.s 
	$(AS) $< -o $@

%: %.s

.PHONY: clean mizo mika 

mizo: file
	scp $< 250373b@172.21.43.173:
mika: file
	scp $< 172.21.43.172:

clean:
	rm -f *.o *~ *.out *.img *.elf
