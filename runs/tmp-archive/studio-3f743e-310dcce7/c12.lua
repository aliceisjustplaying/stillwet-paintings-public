-- probe canvas bounds
probe = rect(0, 1300, 100, 10)
print("area:", probe:area())
r2 = rect(0, 1250, 900, 25)
work(r2, {hand="detail", pile=sk4, coverage=1.5, edge=0.2, clip=true, ruler=true})
print("painted 1250")
