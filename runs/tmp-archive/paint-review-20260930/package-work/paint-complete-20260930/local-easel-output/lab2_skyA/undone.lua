--@ undone 1 · was chunk 2 · undone · 263 bytes

work(skym, {hand="broad", color=skycol, angle=0, coverage=3, medium=0.3, pal=skypal})
work(clouds, {hand="broad", color=cloudcol, angle=0, coverage=3, medium=0.3, pal=skypal, clip=clouds})
work(land, {hand="body", color=stripcol, angle=0, coverage=3, clip=land})

--@ undone 2 · was chunk 5 · undone · 732 bytes

-- A4: next day, the lit undersides scumbled warm, the tops darkened with a glaze veil
dry()
local function c2(x, y) if y < 320 then return 196 + 22*bn(x*0.6, 0) + 0.035*(x - 500) end return 452 + 14*bn(x, 90) - 0.03*(x - 500) end
litm = (clouds * mask(function(x, y) return smoothstep(c2(x, y) + 2, c2(x, y) + 14, y) * math.exp(-((x - SUNX)/340)^2) end)):blur(3)
topm = (clouds * mask(function(x, y) return 1 - smoothstep(c2(x, y) - 14, c2(x, y) + 2, y) end)):blur(4)
work(litm, {hand="scumble", color=function(x, y) return y < 320 and "#c9a898" or "#efc890" end, coverage=2.2, medium=0.35, hug=false, pal=skypal})
work(topm, {hand="glaze", medium=0.8, color_over={shift={-0.05, 0, -0.012}}})
blend(clouds, {angle=0, clip=clouds})

