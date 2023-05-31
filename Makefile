# Makefile - builds everything and installs them properly.
# Copyright (c) 2023 Yiğit Cemal Öztürk. Licensed under
# WTFPL. See LICENSE for more details.


# variables for building the project.
PROJECTNAME := autoupdated
TARGETDIR := build

# variables for installation
USERNAME := root
DAEMON := systemctl
SERVICENAME := autoupdated
PREFIX := /

# cleans the build directory.
# run before every single git action

clean: build/$(PROJECTNAME)
	rm -rf ./build

# compiles the project.
build: $(PROJECTNAME).sh
	if [ ! -d ./build ]; then
		mkdir ./build
	fi
	cp ./$(PROJECTNAME).sh ./build/$(PROJECTNAME)
	chmod a+x ./build/$(PROJECTNAME)

# runs the project
run: build
	exec ./build/$(PROJECTNAME)

# installs the project (critical script)
install: build
	cp ./build/$(PROJECTNAME) /bin/$(PROJECTNAME)
	awk \
	       	-v USERNAME='$(USERNAME)' \
		-v DAEMON='$(DAEMON)' \
	        -v PREFIX='$(PREFIX)' \
		-v SERVICENAME='$(SERVICENAME)' \
		-f systemd-template.awk \
		1> ./build/tmp.service
	cp ./build/tmp.service /etc/systemd/system/$(SERVICENAME).service
	systemctl start $(SERVICENAME)
	systemctl enable $(SERVICENAME)
		
