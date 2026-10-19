local out = (ellipse(265,501,14,8) + ellipse(297,492,14,8) + ellipse(334,489,13,7.5) + ellipse(379,496,15,8)):roughen(1.2, 5, 111)
out = out - river2:grow(1.0)
work(out, {hand="detail", pile=gG, angle=0, coverage=3, length={3,8}, fill=true, clip=true, edge="soft"})
print(wait(0))
