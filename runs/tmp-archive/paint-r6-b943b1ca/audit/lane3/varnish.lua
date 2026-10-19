--@ chunk 1
canvas{style="friedrich", aspect=1.5, seed=2, hand=true}
--@ chunk 2
work(rect(100, 100, 300, 200), {hand="body", color="#8090a0"})
local t = timesheet(); print(string.format("before clock %.2f sitting %.2f hours %.2f", t.clock, t.sitting, t.hours))
--@ chunk 3
varnish()
local t = timesheet(); print(string.format("after clock %.2f sitting %.2f sittings %d", t.clock, t.sitting, t.sittings))
