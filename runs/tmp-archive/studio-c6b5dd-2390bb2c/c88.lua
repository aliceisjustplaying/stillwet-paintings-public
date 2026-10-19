crown2 = outline{{384,440,"c"},{388,420},{394,404},{404,392},{414,384},{426,381},{438,386},{447,397},{452,410},{456,424},{462,440,"c"}, closed=true, char="soft", seed=171, lobe=7, amount=1.1}
crown2M = crown2:mask()
wz = (rect(380, 334, 170, 84):roughen(6, 20, 172, 0) - crown2M - trees:shrink(2)) * above(function(x) return 418 end)
work(wz, {hand="body", tool="filbert 6", pile=pGap, angle=0, angle_jitter=0.08, coverage=3.5, load=0.85, fill=true, length={15,40}, clip=wz})
