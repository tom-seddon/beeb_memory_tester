# -*- mode:makefile-gmake; -*-
##########################################################################
##########################################################################

ifeq ($(OS),Windows_NT)
TASS?=bin\64tass.exe
else
TASS?=64tass
endif

PYTHON?=python

TASSCMD:=$(TASS) --m65c02 --cbm-prg -Wall -C --line-numbers

VOLUME:=beeb/
DEST:=$(VOLUME)/0
TMP:=build
SSD:=ssds

BEEB_BIN:=submodules/beeb/bin
SHELLCMD:=$(PYTHON) submodules/shellcmd.py/shellcmd.py

##########################################################################
##########################################################################

.PHONY:build
build:
	$(SHELLCMD) mkdir "$(VOLUME)/0"
	$(SHELLCMD) mkdir "$(TMP)"
	$(MAKE) _assemble SRC=test_upper_16k BBC=TESTTOP
#	$(MAKE) _assemble SRC=test_lower_16k BBC=TESTBOT

##########################################################################
##########################################################################

.PHONY:_assemble
_assemble:
	$(TASSCMD) "$(SRC).s65" "-L$(TMP)/$(SRC).lst" "-l$(TMP)/$(SRC).sym" "-o$(TMP)/$(SRC).prg"
	$(PYTHON) $(BEEB_BIN)/prg2bbc.py "$(TMP)/$(SRC).prg" "$(DEST)/@.$(BBC)"
