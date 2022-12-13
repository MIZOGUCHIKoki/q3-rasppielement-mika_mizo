AS = arm-none-eabi-as 
LD = arm-none-eabi-ld
OBJ = arm-none-eabi-objcopy
LDFRAGS = -m armelf
OBJFLAGS = -O binary


%: %.elf
	$(OBJ) $< $(OBJFLAGS) $@

%.elf: %.o
	$(LD) $(LDFRAGS) $+ -o $@

%.o: %.s
	$(AS) $< -o $@

.PHONY: clean mizo mika yama tana

mizo: file
	scp $< 250373b@172.21.43.173:
mika: file
	scp $< 172.21.43.172:
tana: file
	scp $< 172.21.43.172:
yama: file
	scp $< 172.21.43.172:


clean:
	rm -f *.o *~ *.out *.img
