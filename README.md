# pwn_container

My environment for binary exploitation.

Includes pwninit, pwndbg, r2, pwntools, angr, ROPgadget, one_gadget, and more.

tmux config mostly from here:
https://www.seanh.cc/2020/12/30/how-to-make-tmux%27s-windows-behave-like-browser-tabs/

## Usage

```bash
podman build . -t pwn_container
alias pwn='podman run -v ~/pwn:/pwn --cap-add=SYS_PTRACE --userns=keep-id -it pwn_linux /bin/bash'
pwn
```

## Notes

Since tmux mouse mode is enabled, copying and pasting won't work as normal. Hold shift while highlighting, copying, and pasting in your terminal to override the weird behavior.
