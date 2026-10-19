millP = pile{{"lead white",0.6},{"smalt",1},{"red earth",0.3},{"raw umber",0.9}}
farSailP = pile{{"lead white",1.8},{"smalt",0.7},{"red earth",0.5},{"raw umber",0.4}}
-- windmill tower on the far shore
local tower = poly({{575,438},{584,438},{581.5,421},{577.5,421}})
local cap = ellipse(579.5,420,3.2,2.2)
work(tower + cap, {hand="detail", pile=millP, coverage=3, fill=true, clip=true})
local r = brush{kind="rigger", width=1.3, point=1}
local arms = {{-11,-8},{11,8},{-9,10},{9,-10}}
for _, a in ipairs(arms) do
  r:reload(millP, 0.6)
  r:stroke({{579.5,419.5},{579.5 + a[1], 419.5 + a[2]}}, {pressure={0.55,0.35}})
end
-- a distant sail far off to the right
local fs = outline{{661,417,"c"},{666,437,"c"},{655,437,"c"}, closed=true, char="firm", amount=0.2, seed=141}:mask()
work(fs, {hand="detail", pile=farSailP, coverage=3, fill=true, clip=true})
local fh = poly({{651,437},{670,437},{668,440},{654,440}})
work(fh, {hand="detail", pile=millP, coverage=3, fill=true, clip=true})
