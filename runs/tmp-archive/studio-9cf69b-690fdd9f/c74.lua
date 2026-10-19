local m = ellipse(93, 645, 22, 4.5) + ellipse(152, 627, 18, 3.8) + ellipse(214, 610, 14, 3.2)
m = m - postsM
work(m, {hand="detail", pile=fieldB, coverage=3, pressure={0.5,0.8}, load=0.9, fill=true, angle=0, tool={kind="round", width=1.6}})
blend((m + ellipse(93, 640, 22, 9) + ellipse(152, 622, 18, 8) + ellipse(214, 606, 14, 6)) - postsM, {angle=0, tool={kind="badger", width=8}})
