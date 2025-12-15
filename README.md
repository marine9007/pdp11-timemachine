# 2.11BSD on SIMH PDP-11 Emulator

🖥️ **Back to the sysadmin office, 1983-1987** — four years running the PDP-11, your own office with the toaster oven and coffee pot, Wednesday bagel day, and that green phosphor glow while you kept the mainframe alive. The Dragons had the keys to the kingdom, and now you can relive it all (minus the actual hardware maintenance) right on your Windows or Mac machine.

Run real Unix from 1980s on your PC or Mac!

## Setup

### Windows

**1. Download SIMH emulator:**
- [SIMH Windows Binaries](https://github.com/simh/simh/releases) — grab the latest Windows release, extract next to this folder

**2. Download the 2.11BSD disk image:**
- Search for `211bsd.dsk` (~170MB) — the original link may be outdated. Try:
  - [Archive.org](https://archive.org/search.php?query=211bsd.dsk) — search for "211bsd.dsk"
  - [PDP-11 Resources](https://pdp-11.trailing-edge.com/) — check for disk images
  - GitHub repositories with SIMH disk images
- Place `211bsd.dsk` in this folder once downloaded

### macOS

**1. Download SIMH emulator:**
- [SIMH macOS Binaries](https://github.com/simh/simh/releases) — grab the latest macOS/Darwin release, extract next to this folder
- Or install via Homebrew: `brew install simh`

**2. Download the 2.11BSD disk image:**
- Search for `211bsd.dsk` (~170MB) — the original link may be outdated. Try:
  - [Archive.org](https://archive.org/search.php?query=211bsd.dsk) — search for "211bsd.dsk"
  - [PDP-11 Resources](https://pdp-11.trailing-edge.com/) — check for disk images
  - GitHub repositories with SIMH disk images
- Place `211bsd.dsk` in this folder once downloaded

**3. Make executable (if needed):**
```bash
chmod +x ../simh-*/pdp11
```

## Quick Start

### Windows

**Option 1:** Double-click `run_unix.bat` or run `./run_unix.sh` (Git Bash)

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

### macOS

**Option 1:** Run the launcher script:
```bash
./run_unix.sh
```

**Option 2:** Manual launch (run from this folder):
```bash
../simh-*/pdp11 boot.ini
```

Or if SIMH is in a different location:
```bash
/path/to/simh/pdp11 boot.ini
```

Or if installed via Homebrew:
```bash
pdp11 boot.ini
```

### What the launch command does

| Part | Explanation |
|------|-------------|
| `../simh-*/` or path | Path to SIMH emulator folder (extracted from GitHub release) |
| `PDP11.exe` (Windows) or `pdp11` (macOS) | The PDP-11 hardware emulator executable |
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

1. Run the command above
2. At the `:` prompt → **Press Enter** (blank input)
3. Watch boot messages scroll
4. At `#` prompt (single user) → **Press Ctrl+D**
5. At `login:` → Type **root** (no password)

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

### Command History

**Important:** The default shell (`/bin/sh`) doesn't have command history. Arrow keys won't work for history navigation — that's a modern feature.

**To enable history, switch to C shell:**

```bash
csh
```

**Check your current shell:**
```bash
echo $SHELL
```

**Make csh your default shell:**
```bash
chsh
```
When prompted, enter: `/bin/csh`

**Using history in csh:**

| Command | Description |
|---------|-------------|
| `history` | show numbered list of past commands |
| `!!` | repeat last command |
| `!n` | repeat command number n (from history list) |
| `!-2` | repeat 2 commands ago |
| `!ls` | repeat last command starting with "ls" |

**Set history size** (add to `~/.cshrc`):
```bash
set history = 100
```

**Note:** Arrow keys for history navigation didn't exist in 1991-era Unix. Use `history` to see command numbers, then `!n` to repeat them.

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
| `run_unix.sh` | Git Bash / macOS launcher |

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

## Example Boot Output

Here's what a successful boot sequence looks like:

```
$ ../pdp11 boot.ini
PDP-11 simulator V4.0-0 Current        git commit id: 670a3728
Disabling XQ
./boot.ini-12> set cpu 11/84
%SIM-INFO: RQ: RQDX3 controller not valid on a Unibus system, changing to UDA50
%SIM-INFO: RQB: RQDX3 controller not valid on a Unibus system, changing to UDA50
%SIM-INFO: RQC: RQDX3 controller not valid on a Unibus system, changing to UDA50
%SIM-INFO: RQD: RQDX3 controller not valid on a Unibus system, changing to UDA50
./boot.ini-14> attach rp0 211bsd.dsk
%SIM-INFO: RP0: './211bsd.dsk' Contains BSD 2.11 partitions
%SIM-INFO: Partition with highest sector: b, Sectors On Disk: 340670
84Boot from xp(0,0,0) at 0176700
: 
: xp(0,0,0)unix
Boot: bootdev=05000 bootcsr=0176700
2.11 BSD UNIX #115: Sat Apr 22 19:07:25 PDT 2000
    sms1@curly.2bsd.com:/usr/src/sys/GENERIC
phys mem  = 3932160
avail mem = 3708224
user mem  = 307200
hk 0 csr 177440 vector 210 attached
ht ? csr 172440 vector 224 skipped:  No CSR.
ra 0 csr 172150 vector 154 vectorset attached
rl 0 csr 174400 vector 160 attached
tm 0 csr 172520 vector 224 attached
tms 0 csr 174500 vector 260 vectorset attached
ts ? csr 172520 vector 224 interrupt vector already in use.
xp 0 csr 176700 vector 254 attached
erase, kill ^U, intr ^C
# Fast boot ... skipping disk checks
/dev/ra0a on /: Specified device does not match mounted device.
checking quotas: done.
ra0: Ver 3 mod 2
ra0 st=3 sb=1 fl=0 en=9
/dev/swap: Input/output error
Assuming non-networking system ...
checking for core dump...
preserving editor files
clearing /tmp
standard daemons: update cron accounting.
starting lpd
starting local daemons: sendmail.
Wed Aug 23 19:40:09 PDT 2006
2.11 BSD UNIX (curly.2bsd.com) (console)
login: root
erase, kill ^U, intr ^C
# ls
.cshrc         .tiprc         etc            mnt            usr
.hushlogin     README         genunix        sbin           var
.kermrc        VERSION        hostid.core    sendmail.core  vmunix
.login         a              lib            sys
.mailrc        bin            lost+found     tmp
.profile       boot           lpd.core       toyset
.rhosts        dev            mdec           unix
#
```

---
Source: http://simh.trailing-edge.com/
