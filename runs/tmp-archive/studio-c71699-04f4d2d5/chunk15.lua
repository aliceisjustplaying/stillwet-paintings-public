local handle_ribbon = ribbon({{630, 355}, {675, 365}, {696, 410}, {692, 455}, {668, 485}}, 16)
local wall_mask_full = rect(0, 0, 1000, 525) - pitcher_full - handle_ribbon
blend(wall_mask_full, {angle = 0, coverage = 2.2})
print("Full wall blended seamlessly.")
