#!/bin/bash

total_mem=$(sysctl -n hw.memsize)
# vm_stat reports pages; get page size:
page_size=$(vm_stat | head -n1 | awk '{print $8}')

# Get wired memory
wired_pages=$(vm_stat | awk '/Pages wired down/ {print $4}' | sed 's/\.//')
wired_mem=$((wired_pages * page_size))

# Get compressed memory
compressed_mem=$(sysctl -n vm.compressor_bytes_used)

# Get app memory (total minus free - inactive - speculative - wired - compressed - purgeable)
free_pages=$(vm_stat | awk '/Pages free/ {print $3}' | sed 's/\.//')
inactive_pages=$(vm_stat | awk '/Pages inactive/ {print $3}' | sed 's/\.//')
spec_pages=$(vm_stat | awk '/Pages speculative/ {print $3}' | sed 's/\.//')
purgeable_mem=$(sysctl -n vm.purgeable_mem)

# Calculate app memory like Activity Monitor does
app_mem=$(( total_mem - ((free_pages + inactive_pages + spec_pages) * page_size) - purgeable_mem - wired_mem - compressed_mem ))

used_mem=$(( app_mem + wired_mem + compressed_mem ))
used_percent=$(( 100 * used_mem / total_mem ))

sketchybar -m --set "$NAME" label="${used_percent}%"
