#!/usr/bin/env python3

from math import floor


def round_half_up(n, decimals=0):
    multiplier = 10**decimals
    return floor(n * multiplier + 0.5) / multiplier


with open("/sys/class/power_supply/BAT0/energy_full") as full_file:
    full = int(full_file.read().strip())

with open("/sys/class/power_supply/BAT0/energy_full_design") as full_design_file:
    full_design = int(full_design_file.read().strip())

print(full, full_design)
capacity = round_half_up(full / full_design * 100, 2)
print(f"Capacity = {capacity}")
