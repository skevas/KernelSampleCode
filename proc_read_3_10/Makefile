ifneq ($(KERNELRELEASE),)
   obj-m := proc_read_3_10.o
else

#KERNELDIR ?= /lib/modules/$(shell uname -r)/build
KERNELDIR ?= /usr/src/linux/

PWD := $(shell pwd)

default:
	$(MAKE) -C $(KERNELDIR) M=$(PWD) modules
endif
clean:
	$(MAKE) -C $(KERNELDIR) M=$(PWD) clean
