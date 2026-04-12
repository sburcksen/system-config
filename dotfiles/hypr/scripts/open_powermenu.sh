#!/usr/bin/env bash

# Opens wlogout only if its not currently running
if [[ $(pgrep wlogout) -eq 0 ]]; then
    wlogout
fi
