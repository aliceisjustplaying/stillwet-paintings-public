function grad(cx, cy, rx, ry, kx, ky, lo, hi)
  return mask(function(x,y)
    local ux = (x-cx)/rx
    local uy = (y-cy)/ry
    local t = 0.5 + 0.5*(ux*kx + uy*ky)
    return clamp((t-lo)/(hi-lo), 0, 1)
  end)
end
lemA = poly({{540,500},{552,486},{558,468},{576,456},{600,452},{624,458},{642,472},{650,488},{660,498},{650,512},{642,528},{624,540},{600,546},{576,540},{558,528},{552,514}}, true)
lemB = poly({{648,506},{660,494},{666,478},{682,468},{702,464},{722,470},{736,482},{744,494},{752,506},{744,518},{736,532},{722,542},{702,546},{682,542},{666,530},{660,518}}, true)
lemC = poly({{66,652},{76,638},{88,624},{110,614},{136,612},{158,618},{172,630},{180,642},{178,656},{168,668},{150,676},{126,678},{102,674},{84,666},{72,660}}, true)
pear = poly({{850,520},{864,532},{876,552},{882,578},{880,608},{870,632},{852,650},{830,654},{810,644},{800,624},{798,598},{804,572},{816,548},{832,530},{844,520}}, true) + ribbon({{850,524},{858,506},{864,494}}, {6,4,2.5})
plemon = pile{{"chrome yellow",3},{"lead white",1.5},{"yellow ochre",0.6}}
ppear = pile{{"yellow ochre",2},{"green earth",1.5},{"lead white",2},{"chrome yellow",0.5}}
work(lemA + lemB, {hand="body", pile=plemon, clip=true, coverage=3.2, fill=true, seed=231})
work(lemC, {hand="body", pile=plemon, clip=true, coverage=3.2, fill=true, seed=232})
work(pear, {hand="body", pile=ppear, clip=true, coverage=3.2, fill=true, seed=233})
print("ok")
