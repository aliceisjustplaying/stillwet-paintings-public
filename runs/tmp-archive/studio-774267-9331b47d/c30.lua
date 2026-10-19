local sh = pile{{"smalt", 1.2}, {"pale smalt", 0.8}, {"raw umber", 0.5}, {"bone black", 0.12}, {"lead white", 0.5}, medium=0.3}
local shm = nil
for _,t in ipairs(TW) do
  local by = far(t.x) + 1.5
  local r = rect(t.x - t.w/2 + t.w*0.38, t.body - 20, t.w*0.62 + 1.2, by - t.body + 20)
  shm = shm and (shm + r) or r
end
shm = (shm + rect(540, 355, 300, 40) - rect(0,0,1000,352)) * TOWN
TOWNSH = shm
work(shm, {hand="detail", pile=sh, coverage=1.6, fill=true, seed=3001})
