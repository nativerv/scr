# `scr` is a minimalistic cross-display-server screenshotting utility written in POSIX shell 

## Description

It wraps [maim](https://github.com/naelstrof/maim)/[grim](https://git.sr.ht/~emersion/grim) and freezes the screen with [sxiv](https://github.com/xyb3rt/sxiv)/[imv](https://sr.ht/~exec64/imv/) for selection (in selection mode).

## Usage

`scr [-s] [path]`

- If `-s` is given, select an area to capture.

- If `path` is given, save as the `path`. Otherwise, save in XDG pictures directory in `scr` subfolder, e.g. `~/Pictures/scr`.

## See also

- [sxhkd](https://github.com/baskerville/sxhkd) - simple X hotkey daemon
