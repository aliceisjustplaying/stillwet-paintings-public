-- Registered streak bands, masks the right way round
deep2 = pile{{"lead white", 0.75}, {"cobalt blue", 0.95}, {"raw umber", 0.6}, {"bone black", 0.5}, {"green earth", 0.35}, {"vermilion", 0.1}}
deep3 = pile{{"lead white", 0.6}, {"cobalt blue", 1.0}, {"raw umber", 0.7}, {"bone black", 0.6}, {"green earth", 0.4}, {"vermilion", 0.08}}
flare  = pile{{"lead white", 1.6}, {"chrome yellow", 0.35}, {"vermilion", 0.2}, {"cobalt blue", 0.12}}
spit_edge = function(x) return 1150 + 26 * math.sin(x / 90 + 1) + 14 * math.sin(x / 38 + 2) - 0.28 * x end
notbank = mask(function(x, y) return y < spit_edge(x) and 1 or 0 end)

bands = {
  {695, 748, flare, 0.5},
  {778, 828, deep2, 0.55},
  {848, 908, deep2, 0.6},
  {928, 988, flare, 0.35},
  {1012, 1078, deep3, 0.6},
  {1105, 1185, deep3, 0.65},
}
for _, bd in ipairs(bands) do
  local m = below(function(x) return bd[1] - 10 * math.sin(x / 71) end)
          * above(function(x) return bd[2] + 10 * math.sin(x / 64 + bd[1]) end)
          * notbank
  work(m, {hand="broad", pile=bd[3], coverage=bd[4], angle=0.0, pressure={0.55, 0.75}, edge=1})
  blend(m, {coverage=0.7})
end
print("streaks laid")
