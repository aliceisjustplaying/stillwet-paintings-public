local keep = (FPATH + ALLCOCKS + FENCE + HORSEA + HORSEB):grow(2)
for i,b in ipairs({{538,8},{555,8},{512,6}}) do
  local m = rect(-5, b[1]-b[2], 1010, 2*b[2]) - keep
  for k=1,3 do blend(m, {angle=0, angle_jitter=0.05, length={20,60}, tool={kind="badger", width=8}, seed=860+i*10+k}) end
end
