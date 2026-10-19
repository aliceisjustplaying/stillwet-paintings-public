-- living bark wraps the foot of each dead limb
local joins = {
  {pts={{194,262},{195,238},{197,214},{198,200}}, ws={13,12,11,10}},
  {pts={{222,274},{240,258},{254,247},{263,232}}, ws={10,9,8.5,8}},
  {pts={{200,176},{203,168},{210,160}}, ws={7,6.5,6}},
}
local m = nil
for _,s in ipairs(joins) do local r = ribbon(s.pts, s.ws); m = m and (m + r) or r end
m = m + ellipse(152,323,5,5)
m = m:roughen(0.7,5,21)
work(m, {hand="detail", pile=barkDark, coverage=4, pressure={0.6,0.9}, load=1, fill=true, angle=-math.pi/2, angle_jitter=0.4})
-- ragged bark edge where living wood gives out: a few tongues up the dead wood
local r = brush{kind="round", width=3, point=1}
r:load(barkDark, 0.7)
for _,t in ipairs({{193,202,191,186},{201,203,203,190},{258,236,262,222},{267,238,270,226},{209,162,214,154}}) do
  r:stroke({{t[1],t[2]},{t[3],t[4]}}, {pressure={0.7,0.05}})
end
