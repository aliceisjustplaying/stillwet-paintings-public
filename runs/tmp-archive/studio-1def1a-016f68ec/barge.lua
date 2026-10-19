sailP = pile{{"red earth",1},{"raw umber",0.7},{"vermilion",0.1},{"lead white",0.15}}
sail2P = pile{{"red earth",1},{"raw umber",0.9},{"bone black",0.1},{"lead white",0.2},{"smalt",0.2}}
hullP = pile{{"bone black",1},{"raw umber",0.8},{"smalt",0.3}}
mainsail = outline{{303,208,"c"},{335,196},{371,186,"c"},{380,300},{391,437,"c"},{345,441},{304,441,"c"}, closed=true, char="firm", amount=0.4, seed=31}
topsail = outline{{303,150,"c"},{334,178},{363,193,"c"},{303,205,"c"}, closed=true, char="firm", amount=0.4, seed=32}
foresail = outline{{297,186,"c"},{296,440,"c"},{262,441},{226,442,"c"},{268,320}, closed=true, char="firm", amount=0.4, seed=33}
mizzen = outline{{393,388,"c"},{407,381,"c"},{411,445,"c"},{395,446,"c"}, closed=true, char="firm", amount=0.3, seed=34}
work(mainsail:mask(), {hand="body", tool="filbert 5", pile=sailP, angle=-1.5, angle_jitter=0.1, coverage=3, fill=true, edge="firm", length={20,50}})
work(topsail:mask(), {hand="body", tool="filbert 4", pile=sailP, angle=-1.5, coverage=3, fill=true, edge="firm", length={15,40}})
work(foresail:mask(), {hand="body", tool="filbert 5", pile=sail2P, angle=-1.25, coverage=3, fill=true, edge="firm", length={20,50}})
work(mizzen:mask(), {hand="detail", pile=sailP, angle=-1.5, coverage=3, fill=true})
