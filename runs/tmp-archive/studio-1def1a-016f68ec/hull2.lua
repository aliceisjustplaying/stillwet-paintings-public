hull2 = outline{{214,440,"c"},{260,446},{340,447},{414,442,"c"},{407,461,"c"},{320,465},{232,461,"c"}, closed=true, char="firm", amount=0.25, seed=71}
local hm = hull2:mask() + rect(228,436,184,8)
work(hm, {hand="detail", pile=hullP, angle=0, coverage=3.5, fill=true, clip=true})
hullR2 = outline{{234,462,"c"},{320,466},{406,462,"c"},{396,472},{320,478},{246,472}, closed=true, char="soft", amount=0.5, seed=72}:mask()
work(hullR2, {hand="detail", pile=reflDark, angle=0, coverage=2.5, fill=true})
