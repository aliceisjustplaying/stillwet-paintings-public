-- fill the table of sky trials into the spare band, then look
trials = {sk1, sk2, sk3, sk4}
names = {"sk1","sk2","sk3","sk4"}
for i, m in ipairs(trials) do
  local x0 = 0 + (i-1) * 250
  local band = rect(x0, 1252, 248, 30)
  work(band, {hand="detail", pile=m, coverage=2.0, edge=0.2, clip=true, ruler=true})
end
print("trials painted")
