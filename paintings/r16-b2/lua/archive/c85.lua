bglz = pile{{"green earth",1.3},{"yellow ochre",0.6},{"raw umber",0.8},{"lead white",0.3}, medium=0.6}
bglz2 = pile{{"green earth",1.2},{"raw umber",1.2},{"pale smalt",0.3}, medium=0.6}
local nz = noise{seed=851, period=60, octaves=2}
local function band(yc, h, p, seed, keep)
  local m = rect(-5, yc-h, 1010, 2*h) - keep
  work(m, {hand="scumble", pile=p, tool={kind="filbert", width=5}, angle=0, angle_jitter=0.1, coverage=1.3, fill=false, length={15,40}, pressure={0.25,0.45},
    load_at=function(x,y) local d = math.abs(y-yc-3*nz(x,y))/h; return clamp(0.4*(1-d*d), 0, 0.4) end, seed=seed})
end
local keep = (FPATH + ALLCOCKS + FENCE + HORSEA + HORSEB):grow(1.5)
band(538, 6, bglz, 852, keep)
band(555, 5, bglz2, 853, keep)
band(512, 4, bglz, 854, keep)
