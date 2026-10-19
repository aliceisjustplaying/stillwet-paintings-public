local function horse(dx, dy, p)
  local function T(pts) local o = {} for i, q in ipairs(pts) do o[i] = {q[1] + dx, q[2] + dy} end return o end
  local body = poly(T({{563,515},{565,513},{575,514},{583,511},{587,507},{590,503},{591,500.5},{592,502},{594,504},{597,510},{596,511.5},{593,511},{590,510},{588,514},{588,518},{583,521.5},{568,521.5},{563.5,519}}), true)
  local legs = ribbon(T({{565.5,519},{565.8,526},{565,532}}), 1.6) + ribbon(T({{569,520},{569.5,526},{570,532}}), 1.5)
             + ribbon(T({{584,520},{584.2,526},{584,532}}), 1.5) + ribbon(T({{587,519},{587.8,525},{588.5,532}}), 1.5)
  local tail = ribbon(T({{563.5,514.5},{561.8,519},{561.5,524}}), {1.4, 1.1, 0.8})
  local m = body + legs + tail
  work(m, {hand="detail", pile=p, angle=0, coverage=3, length={1.5,4}, fill=true, clip=true, edge="found"})
  return m
end
local hb = horse(3.5, -1.2, horseD)
local hf = horse(0, 0, horseB)
-- harness line, collar and the pole
local r = brush{kind="round", width=0.9, point=0.8}
r:load(horseD, 0.5)
r:stroke({{560,521},{575,518},{587,514}}, {pressure={0.4,0.4}})
r:stroke({{566,515},{585,511}}, {pressure={0.35,0.35}})
-- a light on the horse's back and rump from the upper left
local lt = pile{{"red earth", 1}, {"yellow ochre", 1}, {"lead white", 1.2}, medium=0.08}
r:load(lt, 0.4)
r:stroke({{564.5,514.5},{570,513.6},{577,514}}, {pressure={0.4,0.3}})
r:stroke({{584,510.5},{588,506},{590.5,502}}, {pressure={0.35,0.25}})
print(wait(0))
