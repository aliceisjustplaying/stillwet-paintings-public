-- Fuse the sky while it is open
skyzone = below(function(x) return 560 + 20 * math.sin(x / 90) end)
blend(skyzone, {coverage=1.0})
print("sky blended")
