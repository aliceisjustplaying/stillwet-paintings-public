for i=1,230 do
  local x = rand(0,1000)
  local y = 530 + 10*math.sin(x/71) + rand(-3,10)
  local pl = ({gr_dk, gr_olive, gr_dk, gr_rust})[(i%4)+1]
  tuft_at(x, y, pl, 0.85, math.random(3,7), rand(1.6,2.8))
end
