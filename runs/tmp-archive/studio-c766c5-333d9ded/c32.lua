s1 = body.ellipsoid({600,498,0},{52,46,50})
s2 = body.ellipsoid({700,504,0},{48,42,46})
f = form{{s1,dist=0.3},{s2,dist=0.3}, light={from={-1,-0.75}, front=0.55, ambient=0.25}}
print("value at 590,480", f:value(590,480), " lit_at", f:lit_at(590,480,0.15))
litM = f:lit{parts={1,2}, soft=0.15}
shM  = f:shadow{parts={1,2}}
silM = f:silhouette{parts={1,2}}
print("lit area", litM:area(), "shadow area", shM:area(), "sil", silM:area())
work(litM, {hand="body", pile=plight, clip=true, coverage=1.6, seed=261})
work(shM, {hand="body", pile=pdarkL, clip=true, coverage=1.6, seed=262})
