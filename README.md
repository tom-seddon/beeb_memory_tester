# BBC Micro memory tester

To use on your BBC Micro, download `beeb_memory_tester.ssd` and write
it to a floppy disk.

The memory is tested 16 K at a time. There are three test programs for
the lower half - `Tlower3` (runs in mode 3), `Tlower4` (runs in mode
4) and `Tlower7` (runs in mode 7) - and three for the upper half,
similarly: `Tupper3`, `Tupper4` and `Tupper7`.

The test process continues indefinitely until an error is found or you
press BREAK. For all except `Tlower7`, you'll see stuff happening on
screen as the testing process proceeds.

(In principle, the memory ought to behave the same regardless of mode!
But if your Beeb seems unreliable in some mode-dependent fashion, as
mine does, this might help narrow things down...)

# how to build

## POSIX

Prerequisites: Python 2.x on PATH,
[64tass](https://sourceforge.net/projects/tass64/) on PATH

Run `make` from the terminal. (To manually provide path to Python
and/or 64tass, supply `PYTHON=xxx` and/or TASS=xxx` on the make
command line.)

The output is placed in a
[BeebLink](https://github.com/tom-seddon/beeblink) volume, `beeb/` in
the working copy. The output files are stored in drive 1.

Run `make ssd` to produce `beeb_memory_tester.ssd`, suitable for
writing to a disk.

# licence

The BBC Micro memory tester is free software: you can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with this code. If not, see <https://www.gnu.org/licenses/>.
