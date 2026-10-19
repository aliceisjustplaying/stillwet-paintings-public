local mzone = (meadowM - bankM2:grow(1) - riverAll - oakM2:grow(1)) * rect(0, 452, 1000, 150)
blend(mzone, {angle=0, coverage=3, ruler=true, length={120, 300}})
blend(mzone, {angle=0, coverage=2, ruler=true, length={60, 200}, tool="badger 20"})
