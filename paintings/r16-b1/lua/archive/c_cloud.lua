print(wait(24*60))
cloudDusk = pile{{"lead white", 4}, {"smalt", 1.1}, {"vermilion", 0.35}, {"raw umber", 0.35}, medium=0.3}
cloudLit = pile{{"lead white", 5}, {"vermilion", 0.45}, {"chrome yellow", 0.6}, medium=0.2}
local strata = {
 {pts={{560,318},{640,314},{720,316},{800,312},{880,315},{960,311}}, w={2,4,5,4,5,2}},
 {pts={{600,334},{680,331},{760,333},{830,330}}, w={1.5,3.5,3,1.5}},
 {pts={{780,352},{850,349},{930,351},{1000,348}}, w={1.5,3,3.5,3}},
 {pts={{470,346},{540,343},{600,345}}, w={1,2.5,1.2}},
 {pts={{880,292},{940,289},{1000,290}}, w={1,2.5,2.5}},
 {pts={{0,322},{40,320},{80,322}}, w={2.5,3,1}},
}
local cm = nil
for _, s in ipairs(strata) do
  local r = ribbon(s.pts, s.w)
  cm = cm and (cm + r) or r
end
cloudM = (cm:roughen(1.2, 10, 61)) - treeZone
work(cloudM, {hand="detail", pile=cloudDusk, angle=0, coverage=2.5, fill=true, length={8,25}, clip=true})
-- lit lower edges
local lit = cloudM - cloudM:offset(-1.2)
