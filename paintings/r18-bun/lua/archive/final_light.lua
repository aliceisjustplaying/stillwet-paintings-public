m_cl = poly(cpts5, true):roughen(6, 40, 11):soften(2)
bounce_w = pile{{"raw umber",3.6},{"red earth",2.2},{"bone black",2.6}}
cl_hi = pile{{"lead white",4.5},{"raw umber",2.6},{"yellow ochre",0.7}}
-- warm light thrown back onto the wall by the bowl and the fruit
bw = ellipse(600, 430, 300, 150):soften(110)
bw2 = ellipse(600, 400, 190, 100):soften(80)
print(stipple(bw, {pile=bounce_w, width=9, coverage=0.7, feather=0.55, cluster=0.3, clip=true, seed=1930}))
print(stipple(bw2, {pile=bounce_w, width=8, coverage=0.45, feather=0.55, cluster=0.3, clip=true, seed=1931}))
-- and the light reaching across the cloth to the left of the group
cl1 = ellipse(330, 640, 210, 110):soften(80) * m_cl
cl2 = ellipse(280, 660, 130, 70):soften(60) * m_cl
print(stipple(cl1, {pile=cl_hi, width=9, coverage=0.6, feather=0.55, cluster=0.3, clip=true, seed=1932}))
print(stipple(cl2, {pile=cl_hi, width=8, coverage=0.45, feather=0.55, cluster=0.3, clip=true, seed=1933}))
