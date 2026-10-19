-- the shadow came out a hard blue sliver: soften it into the snow
local m = (ellipse(468, 539, 13, 5) - figM:grow(0.8))
work(m, {hand="blend", tool={kind="badger", width=4}, angle=2.9, coverage=3, clip=true})
