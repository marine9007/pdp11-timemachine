# 2.11BSD on SIMH PDP-11 Emulator

🖥️ **Back to the sysadmin office, 1983-1987** — four years running the PDP-11, your own office with the toaster oven and coffee pot, Wednesday bagel day, and that green phosphor glow while you kept the mainframe alive. The Dragons had the keys to the kingdom, and now you can relive it all (minus the actual hardware maintenance) right on your Windows machine.

Run real Unix from 1980s on your PC!

## Setup

**1. Download SIMH emulator:**
- [SIMH Windows Binaries](https://github.com/simh/simh/releases) — grab the latest Windows release, extract next to this folder

**2. Download the 2.11BSD disk image:**
- [211bsd.dsk from trailing-edge.com](http://www.trailing-edge.com/~bqt/pdp11/) — download `211bsd.dsk` (~170MB) and place it in this folder

## Quick Start

**Option 1:** Double-click `run_unix.bat` (Windows) or run `./run_unix.sh` (Git Bash)

**Option 2:** Manual launch (run from this folder):

Git Bash:
```bash
../simh-*/PDP11.exe boot.ini
```

Or if SIMH is in a different location:
```bash
/path/to/simh/PDP11.exe boot.ini
```

CMD/PowerShell:
```cmd
..\simh-*\PDP11.exe boot.ini
```

Or if SIMH is in a different location:
```cmd
C:\path\to\simh\PDP11.exe boot.ini
```

### What the launch command does

| Part | Explanation |
|------|-------------|
| `../simh-*/` or path | Path to SIMH emulator folder (extracted from GitHub release) |
| `PDP11.exe` | The PDP-11 hardware emulator executable |
| `boot.ini` | Our config file that sets up CPU, attaches disk, and boots |

The `boot.ini` file contains:
```ini
set cpu 11/84      ; Emulate a PDP-11/84 processor
set cpu 4M         ; Give it 4MB of RAM (J-11 max)
attach rp0 211bsd.dsk  ; Connect our disk image to drive rp0
boot rp0           ; Boot from that drive
```

### CPU Model Options
Edit `boot.ini` to change the emulated hardware:

| Model | Description |
|-------|-------------|
| `11/84` | Rack-mount MicroPDP, popular in schools (default) |
| `11/83` | Desktop MicroPDP, same J-11 CPU as 11/84 |
| `11/70` | Classic big iron, 22-bit addressing |
| `11/44` | Mid-range workhorse |
| `11/45` | Original Unibus powerhouse |

## Boot Sequence

**Follow these steps exactly:**

1. **Run the launch command** (from Quick Start above)

2. **At the `:` prompt** — Press **Enter** (blank input, or type `xp(0,0,0)unix` and press Enter)
   ```
   :
   ```
   *(Just press Enter here)*

3. **Watch boot messages scroll** — You'll see hardware detection, memory info, etc.

4. **At the `#` prompt** (single user mode) — Press **Ctrl+D**
   ```
   # Fast boot ... skipping disk checks
   ...
   #
   ```
   *(Press Ctrl+D to exit single user mode)*

5. **At `login:` prompt** — Type **root** and press Enter
   ```
   login: root
   ```
   *(Type "root" and press Enter)*

6. **You're in!** You should see a `#` prompt — you're logged in as root.

## You're in Unix!

### Basic Commands

| Command | Description |
|---------|-------------|
| `ls` | list files |
| `ls -la` | detailed list |
| `pwd` | print working directory |
| `cat /etc/passwd` | view users |
| `who` | who's logged in |
| `date` | current date |
| `uname -a` | system info |
| `ps aux` | running processes |
| `df` | disk space |

### Key Directories

| Path | Contents |
|------|----------|
| `/bin` | binary commands |
| `/usr/bin` | more commands |
| `/etc` | config files |
| `/usr/src` | source code! |

### Text Editing (ed - line editor)

```
ed myfile.txt
```

Then: `a` (append) → type text → `.` (end input) → `w` (write) → `q` (quit)

### C Programming

Create file:
```
cat > hello.c
```

Paste this, then press **Ctrl+D**:
```c
main() {
    printf("Hello from 1991!\n");
}
```

Compile and run:
```
cc -o hello hello.c
```
```
./hello
```

### Assembly Programming

Just like the old days — talk directly to the metal. PDP-11 assembly was famous for its clean, orthogonal instruction set.

Create file:
```
cat > hello.s
```

Paste this, then press **Ctrl+D**:
```asm
.globl _main
_main:
    mov $1,r0           / write syscall
    mov $msg,0f
    mov $14.,0f+2       / message length
    sys 0; 0f           / indirect syscall
    rts pc
.data
0: msg; 14.
msg: <Hello, PDP-11!\n>
```

Assemble and run:
```
as -o hello.o hello.s
```
```
ld -o hello hello.o -lc
```
```
./hello
```

**Common PDP-11 Instructions:**

| Instruction | Description |
|-------------|-------------|
| `mov src,dst` | move data |
| `add src,dst` | add |
| `sub src,dst` | subtract |
| `clr dst` | clear (set to 0) |
| `tst src` | test (set condition codes) |
| `cmp src,dst` | compare |
| `beq label` | branch if equal |
| `bne label` | branch if not equal |
| `jsr pc,sub` | jump to subroutine |
| `rts pc` | return from subroutine |
| `sys` | system call |

**Registers:** `r0`-`r5` general purpose, `sp` (r6) stack pointer, `pc` (r7) program counter

### Shutdown

```
sync
```
```
sync
```
```
halt
```

(or just close the window)

## Files

| File | Description |
|------|-------------|
| `211bsd.dsk` | 170MB RP06 disk image with full 2.11BSD *(download separately — see Setup)* |
| `boot.ini` | SIMH configuration script |
| `run_unix.bat` | Windows launcher |
| `run_unix.sh` | Git Bash launcher |

## SIMH Commands (at sim> prompt)

| Command | Description |
|---------|-------------|
| `help` | show help |
| `show cpu` | show CPU config |
| `show rp` | show disk status |
| `cont` | continue after break |
| `quit` | exit simulator |

Press **Ctrl+E** to break into SIMH prompt from running Unix.

## About 2.11BSD

- Released: 1991 (final patches through 2020!)
- Hardware: DEC PDP-11/84 with 4MB RAM (emulated)
- Features: Full Unix with TCP/IP, vi, C compiler, man pages

### The PDP-11 Era (1983-1987)

If you were in a high school or university computer lab in the mid-80s, you lived this:

| Year | What was happening |
|------|-------------------|
| 1983 | Started on an **11/70** or **11/44** — the "big iron" in the back room |
| 1985 | DEC releases the **MicroPDP 11/84** — rack-mount, J-11 chip, suddenly affordable |
| 1985-86 | School finally gets budget approval, installs the upgrade |
| 1987 | Graduate, mass exodus to IBM PC. Commodore 64 just getting boring. |

The 11/84 was DEC's rack-mount MicroPDP — the workhorse that replaced those massive 11/70 cabinets in schools and businesses. Same J-11 chip as the desktop 11/83, but built for the machine room.

This is real Unix history running on your machine!

## Troubleshooting

**Stuck at `:` prompt?** Just press Enter.

**Need to exit?** Press **Ctrl+E** to break into SIMH prompt, then type `quit` and press Enter. Or just close the terminal window.

**Login asking for password?** Some disk images have passwords set. Try pressing Enter (blank password) or check the disk image documentation. You can always exit with Ctrl+E → `quit` if needed.

**No response?** Press Ctrl+E to break, then `quit` to exit.

**Want to start fresh?** Just run the boot command again.

---
Source: http://simh.trailing-edge.com/
