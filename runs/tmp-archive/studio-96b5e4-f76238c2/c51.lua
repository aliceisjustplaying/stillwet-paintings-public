gr_olive = pile{{"green earth",1},{"raw umber",0.8},{"yellow ochre",0.4},{"bone black",0.1}, medium=0.12}
gr_rust = pile{{"raw umber",1},{"red earth",0.35},{"yellow ochre",0.3}, medium=0.12}
local piles = {gr_dk, gr_dk, gr_olive, gr_rust, gr_dk, gr_olive}
for i=1,900 do
  local y = 530 + 190*math.sqrt(rand(0,1))
  local x = rand(0,1000)
  tuft_at(x, y, piles[(i % #piles) + 1], 0.85, math.random(4,8), rand(0.8,1.4))
end
