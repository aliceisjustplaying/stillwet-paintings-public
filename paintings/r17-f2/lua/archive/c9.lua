local gap = (rect(488, 476, 124, 40) * mid_m) - fieldB - hedgerow:grow(0.5) - hedge2:grow(0.5) - horses_keep:grow(1) - load_m:grow(2) - rect(528, 470, 22, 30) - willow1_head:grow(1) - rect(572, 492, 11, 26) - rect(496, 505, 16, 30)
work(gap, {hand="hatch", pile=pastCm, tool={kind="round", width=1.2, point=0.9}, angle=-math.pi/2 + 0.08, length={1.5,3.5}, coverage=1.1, pressure={0.35,0.55}, ramps={0.1,0.6}, clip=gap, clump=0.4})
print(wait(0))
