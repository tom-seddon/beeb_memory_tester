# -*- mode:makefile-gmake; -*-
##########################################################################
##########################################################################
#
# The BBC Micro memory tester is free software: you can redistribute it
# and/or modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this code. If not, see <https://www.gnu.org/licenses/>.
#
##########################################################################
##########################################################################

ifeq ($(OS),Windows_NT)
TASS?=64tass
PYTHON?=py -3
else
TASS?=64tass
PYTHON?=python
endif


TASSCMD:=$(TASS) --m65c02 --cbm-prg -Wall -C --line-numbers --long-branch

VOLUME:=beeb/
DEST:=$(VOLUME)/1
TMP:=build
SSD:=ssds

BEEB_BIN:=submodules/beeb/bin
SHELLCMD:=$(PYTHON) submodules/shellcmd.py/shellcmd.py

##########################################################################
##########################################################################

.PHONY:build
build:
	$(SHELLCMD) mkdir "$(DEST)"
	$(SHELLCMD) mkdir "$(TMP)"
	$(MAKE) _half HALF=upper
	$(MAKE) _half HALF=lower

.PHONY:ssd
ssd:
	$(PYTHON) $(BEEB_BIN)/ssd_create.py -o beeb_memory_tester.ssd $(DEST)/$$.TUPPER3 $(DEST)/$$.TUPPER4 $(DEST)/$$.TUPPER7 $(DEST)/$$.TLOWER3 $(DEST)/$$.TLOWER4 $(DEST)/$$.TLOWER7

##########################################################################
##########################################################################

.PHONY:_half
_half:
	$(MAKE) _half2 HALF=$(HALF) MODE=7
	$(MAKE) _half2 HALF=$(HALF) MODE=4
	$(MAKE) _half2 HALF=$(HALF) MODE=3

.PHONY:_half2
_half2:
	$(MAKE) _assemble SRC=test_$(HALF)_16k BBC=T$(HALF)$(MODE) "ARGS=-Dmode=$(MODE)"

.PHONY:_assemble
_assemble:
	$(TASSCMD) "$(SRC).s65" "-L$(TMP)/$(SRC).lst" "-l$(TMP)/$(SRC).sym" "-o$(TMP)/$(SRC).prg" $(ARGS)
	$(PYTHON) $(BEEB_BIN)/prg2bbc.py "$(TMP)/$(SRC).prg" "$(DEST)/$$.$(BBC)"
