KERNEL_SOURCE=/lib/modules/$(shell uname -r)/build

obj-m += kinpira.o

all:
		make -C $(KERNEL_SOURCE) M=$(PWD) modules

clean:
		make -C $(KERNEL_SOURCE) M=$(PWD) clean
