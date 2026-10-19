local rows = {}
for y = 270, 470, 8 do
  local s = string.format("%3d ", y)
  for x = 584, 704, 4 do
    local d = drying(x, y)
    s = s .. (d == "open" and "." or d == "setting" and "S" or d == "tacky" and "t" or "d")
  end
  print(s)
end
