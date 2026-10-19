tfree = tablemask - objall
wfree = wallmask - objall
pconn = pile{{"raw umber",1.6},{"bone black",1.4},{"smalt",1},{"lead white",0.2}}
contact2 = ellipse(302,616,80,17):soften(10) + ellipse(640,646,116,20):soften(11)
        + ellipse(128,680,58,15):soften(9) + ellipse(852,662,56,15):soften(9)
work(contact2 * tfree, {hand="body", pile=pconn, clip=true, coverage=2.6, seed=801})
-- fruit core shadows at the base
coreL = (grad(600,498,54,48, 0.25, 1.0, 0.62, 1.0) * lemA) + (grad(700,504,50,44, 0.25, 1.0, 0.62, 1.0) * lemB)
work(coreL, {hand="body", pile=pile{{"raw umber",1.4},{"yellow ochre",1.2},{"green earth",0.6}}, clip=true, coverage=1.6, seed=802})
-- warm glow on the wall behind the objects
pgw = pile{{"lead white",1.2},{"yellow ochre",1.2},{"raw umber",1}}
gw = ellipse(480,430,430,225):soften(140) * wfree
work(gw, {hand="broad", pile=pgw, clip=true, coverage=1.2, angle=0.1, seed=803})
