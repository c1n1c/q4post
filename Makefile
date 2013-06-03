#!/usr/bin/env make

DIR = tmp
FILE = hello.txt

all: hello

install:
	@mkdir -pv ${DIR}

create: install
	@touch ${DIR}/${FILE}
	@echo $(if $(wildcard ${DIR}/${FILE}), "touch: файл «${DIR}/${FILE} уже существует", "touch: создан файл «${DIR}/${FILE}»")

hello: create
	echo "Hello" > ${DIR}/${FILE}

clean:
	@rm -rfv ${DIR}

