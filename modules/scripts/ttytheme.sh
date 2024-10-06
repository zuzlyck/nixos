#!/usr/bin/env bash
for tty in /dev/pts/[0-9]; do
  cat ~/.cache/$USER/tty > $tty
done
