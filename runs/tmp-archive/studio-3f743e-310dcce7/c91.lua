-- Blend the gold band's edges out into the mist
softm = rect(270, 95, 730, 200):soften(36)
blend(softm, {coverage=1.2})
blend(softm, {coverage=1.0})
print("gold blended out")
