#!/usr/bin/bash

doc::help_msg() {
    local -r file="$1"
    grep "^##?" "$file" | cut -c 5-
}

doc::help_or_fail() {
    local -r file="$0"
    doc::help_msg "$file"
    exit 1
}
