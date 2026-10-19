bankpal = pal:only{"lead white", "yellow ochre", "raw umber", "bone black", "pale smalt", "red earth"}
BANKP = {top="#4b4737", mid="#3c3729", low="#2d2a22"}
local bw = noise{seed=91, period=180}
local function under(dy, amp) return function(x) local b = 0; for i = 1, #BANK - 1 do if x >= BANK[i][1] and x < BANK[i+1][1] then local t = (x - BANK[i][1]) / (BANK[i+1][1] - BANK[i][1]); b = BANK[i][2] + t * (BANK[i+1][2] - BANK[i][2]) end end; return b + dy + amp * bw(x, dy) end end
bankTop = function(x) return under(0, 0)(x) end
local topBand = bankM * above(under(26, 8))
local midBand = bankM * below(under(18, 8)) * above(under(80, 14))
local lowBand = bankM * below(under(70, 14))
local o = {hand="body", tool="filbert 6", length={25, 70}, coverage=2.6, medium=0.18, pal=bankpal, angle=function(x, y) return -0.02 + 0.04 * bw(x, y) end}
local function pass(m, c, e) local t = {} for k, v in pairs(o) do t[k] = v end; t.color = c; t.edge = e; work(m, t) end
pass(lowBand, BANKP.low, "soft")
pass(midBand, BANKP.mid, "soft")
pass(topBand, BANKP.top, {found=0.4, soft=0.6, period=40, seed=9})
local t = timesheet(); print(t.sitting)
