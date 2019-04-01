wslstart: wslstart.c
	gcc -o $@ $<

clean:
	rm -f *.o wslstart

all: wslstart

install: all
	strip wslstart
	sudo cp wslstart /usr/sbin/wslstart
	sudo chown root:root /usr/sbin/wslstart
	sudo chmod +s /usr/sbin/wslstart
	sudo ln -sf `readlink -f wslstart.sh` /etc/wslstart.sh
	sudo mkdir -p /etc/wslstart.d
	@echo "NOTE: copy wslstart.cmd to your Windows filesystem (/mnt/c/...) "
	@echo "      so you can run the batch script from Windows."

uninstall: 
	sudo rm /usr/sbin/wslstart
	sudo rm /etc/wslstart.sh

